//
//  KMovieDetailViewModel.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

class KMovieDetailViewModel {
    var movieSelected = Variable<KMovie?>(nil)
    var errorMessage = Variable<String?>(nil)
    
    var menuItems = Variable<[KCategory]>([])
    
    var bag = DisposeBag()
    
    var movieIdSelected: Int? // input from list movie
    
    //---
    var controllers = [UIViewController]()
    var olderController = Variable<UIViewController?>(nil)
    var currentController = Variable<UIViewController?>(nil)
    
    
    func getData() {
        //---
        setUpViewController()
        setUpMenuItems()
        getDetailMovie()
        
    }
    
    func getDetailMovie(){
        guard let id = movieIdSelected else { return }
        let movieDetail = KMovieAPI.getDetailMovie(movieId: id).showProgressIndicator()
        
        //-- when success
        movieDetail.subscribe(onNext: { [unowned self] movie in
           self.movieSelected.value = movie
            },
        onError: { [unowned self] mess in
                self.errorMessage.value = mess.localizedDescription
        }).addDisposableTo(bag)
    }
    
    func setUpMenuItems(){
        let listMenu: [KCategory] = [
//            KCategory(title: "Info", isSelected: true),
            KCategory(title: "Trailers", isSelected: false)
//            KCategory(title: "Photos", isSelected: false),
//            KCategory(title: "Reviews", isSelected: false)
        ]
        
        menuItems.value = listMenu
    }
    
    
    func setUpViewController() {
        let vcTrailer = KMovieTrailerViewController.getViewController() as! KMovieTrailerViewController
        vcTrailer.vmMovieTrailer.movieIdSelected = movieIdSelected
        
        //---
        let vcNowPlaying = KMovieViewController.getViewController() as! KMovieViewController
        vcNowPlaying.typeMovie = .nowPlaying
        
        //---
        let vcUpComing = KMovieViewController.getViewController() as! KMovieViewController
        vcUpComing.typeMovie = .upComing
        
        //---
        let vcTopRated = KMovieViewController.getViewController() as! KMovieViewController
        vcTopRated.typeMovie = .topRated
        
        //---
        controllers  = [vcTrailer, vcNowPlaying, vcUpComing, vcTopRated]
        
        //---
        currentController.value = controllers[0]
    }
    
   
    
    func str2dict(_ str: String) -> [String:String] {
        return str.components(separatedBy: "&").reduce([:] as [String:String], {
            var d = $0
            let components = $1.components(separatedBy: "=")
            if components.count == 2 {
                if let key = (components[0] as NSString).removingPercentEncoding, let value = (components[1] as NSString).removingPercentEncoding {
                    d[key] = value
                }
            }
            return d
        })
    }


}
