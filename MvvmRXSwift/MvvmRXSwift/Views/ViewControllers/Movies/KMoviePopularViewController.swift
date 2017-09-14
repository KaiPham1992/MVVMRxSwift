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
        let movies = vmPopularMovie.movieResponse.map {$0!.movies}
        movies.bind(to: tbMovie.rx.items){ table, index, movie in
            let cell = table.dequeueReusableCell(withIdentifier: KCell.movieCell) as! MovieCell
            cell.movie = movie
            return cell
        }.addDisposableTo(bag)
    }
}

//---MARK: UITableViewDelegate
extension KMoviePopularViewController: UITableViewDelegate {
    func configureTable(){
        tbMovie.register(UINib(nibName: KCell.movieCell, bundle: nil), forCellReuseIdentifier: KCell.movieCell)
        tbMovie.delegate = self
        tbMovie.separatorStyle = .none 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  KDevie.getTypeDevice() == TypeDevice.SMALL {
            return tbMovie.frame.height / 2.5
        } else {
            return tbMovie.frame.height / 3
        }
    }
}



