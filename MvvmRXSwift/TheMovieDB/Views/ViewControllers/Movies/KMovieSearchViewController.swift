//
//  KMovieSearchViewController.swift
//  TheMovieDB
//
//  Created by Kai on 10/21/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class KMovieSearchViewController: KBaseViewController {
   @IBOutlet weak var tbMovie: UITableView!    
    var vmMovieSearch = KMovieSearchViewModel()
    let disposeBag = DisposeBag()
    
    var refreshControl = UIRefreshControl()
    
    let tfSearch: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        tf.attributedPlaceholder = NSAttributedString(string: "Search for a movie...", attributes: [NSForegroundColorAttributeName: KColor.whiteColor.withAlphaComponent(0.5)])
        tf.textColor = KColor.whiteColor
        
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addButtonToNavigation(image: KImage.imgSearch, style: .right, action: #selector(btnSearchTapped))
        addBackToNavigation()
        self.navigationItem.titleView = tfSearch
        tfSearch.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 88, height: 36)
    }
    
    func btnSearchTapped() {
        self.tfSearch.endEditing(true)
        vmMovieSearch.inputs.btnSearchTapped.onNext(true)
    }
}

//---MARK: Bind data

extension KMovieSearchViewController {
    func bindData(){
        tfSearch.rx.text.bind(to: vmMovieSearch.inputs.keySearch)
            .addDisposableTo(disposeBag)
        
        bindDataMoives()
        bindError()
        bindRefresh()
        goToDetail()
    }
    
    func bindDataMoives(){
        //-- remember skip(1) , because the first time vmPopularMovie.movieResponse = nil
        let movies = vmMovieSearch.movieResponse.asObservable().skip(1).map { movieResponse -> [KMovie] in
            guard let _movieResponse = movieResponse else { return [] }
            return _movieResponse.movies
        }
        
        //-- show data to table
        movies.bind(to: tbMovie.rx.items){ table, index, movie in
            
            let cell = table.dequeueReusableCell(withIdentifier: KCell.movieCell) as! MovieCell
            cell.movie = movie
            return cell
            
            }.addDisposableTo(bag)
    }
    
    func bindError(){
        //--- handle when error
        vmMovieSearch.outputs.errorMessage.asObservable().skip(1)
            .subscribe(onNext: { [unowned self] errorString in
                self.showErrorMessage(errorMessage: errorString)
            }).addDisposableTo(bag)
    }
    
    func bindRefresh(){
        refreshControl.rx.controlEvent(UIControlEvents.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.vmMovieSearch.inputs.refreshMovie()
                self?.refreshControl.endRefreshing()
            }).addDisposableTo(bag)
    }
    
    func goToDetail(){
        tbMovie.rx.modelSelected(KBaseModel.self).subscribe(onNext: { [weak self] movie in
            guard let _self = self, let _movie = movie as? KMovie else { return }
            let vc = KMovieDetailViewController.getViewController(fromAppStoryboard: .movie)
            vc.vmMovieDetail.movieIdSelected = _movie.id
            _self.navigationController?.pushViewController(vc, animated: true)
            
        }).addDisposableTo(bag)
    }
}


//---MARK: UITableViewDelegate
extension KMovieSearchViewController: UITableViewDelegate {
    func configureTable(){
        tbMovie.register(UINib(nibName: KCell.movieCell, bundle: nil), forCellReuseIdentifier: KCell.movieCell)
        tbMovie.delegate = self
        tbMovie.separatorStyle = .none
        
        //--- load more
        tbMovie.addInfiniteScrolling(actionHandler: { [unowned self] in
            self.tbMovie.infiniteScrollingView.stopAnimating()
            self.vmMovieSearch.inputs.loadMoreMovie()
        })
        
        //-- refesh
        tbMovie.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  KDevie.getTypeDevice() == TypeDevice.SMALL {
            return tbMovie.frame.height / 2
        } else {
            return tbMovie.frame.height / 3
        }
    }
}
