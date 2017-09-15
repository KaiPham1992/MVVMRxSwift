//
//  KMoviePopularViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KMoviePopularViewController: KBaseViewController {
    @IBOutlet weak var tbMovie: UITableView!
    
    var vmPopularMovie = KMoviePopularViewModel()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        configureTable()
    }
    
    static func getViewController() -> UIViewController {
        return UIStoryboard.movieStoryBoard().instantiateViewController(withIdentifier: "KMoviePopularViewController")
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addButtonToNavigation(image: KImage.imgCategory, style: .left, action: nil)
    }
    
    func bindUI() {
        handleDataMoives()
        handleError()
        handleLoading()
    }
}

//---MARK: action
extension KMoviePopularViewController {
    func handleDataMoives(){
        //-- remember skip(1) , because the first time vmPopularMovie.movieResponse = nil
        let movies = vmPopularMovie.movieResponse.asObservable().skip(1).map { $0!.movies }
        
        //-- show data to table
        movies.bind(to: tbMovie.rx.items){ table, index, movie in
            let cell = table.dequeueReusableCell(withIdentifier: KCell.movieCell) as! MovieCell
            cell.movie = movie
            return cell
            }.addDisposableTo(bag)
    }
    
    func handleLoading(){
        //-- show or hide indicator when isLoading changed
        vmPopularMovie.isLoading.subscribe(onNext:  { [unowned self] isLoading in
            isLoading == true ? self.showActivityIndicator(): self.hideActivityIndicator()
        }).addDisposableTo(bag)
    }
    
    func handleError(){
        //--- handle when error
        vmPopularMovie.errorMessage.subscribe(onNext: { [unowned self] errorString in
            self.showErrorMessage(errorMessage: errorString)
        }).addDisposableTo(bag)
    }
}


//---MARK: UITableViewDelegate
extension KMoviePopularViewController: UITableViewDelegate {
    func configureTable(){
        tbMovie.register(UINib(nibName: KCell.movieCell, bundle: nil), forCellReuseIdentifier: KCell.movieCell)
        tbMovie.delegate = self
        tbMovie.separatorStyle = .none
        
        //--- load more
        tbMovie.addInfiniteScrolling(actionHandler: { [unowned self] in
            self.tbMovie.infiniteScrollingView.stopAnimating()
            self.vmPopularMovie.loadMoreMovies()
        })
        
        //-- 
        refreshControl.addTarget(self , action: #selector(pullToRefresh), for: .valueChanged)
        tbMovie.addSubview(refreshControl)
    }
    
    func pullToRefresh(){
        refreshControl.endRefreshing()
        vmPopularMovie.refreshMovies()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  KDevie.getTypeDevice() == TypeDevice.SMALL {
            return tbMovie.frame.height / 2.5
        } else {
            return tbMovie.frame.height / 3
        }
    }
}



