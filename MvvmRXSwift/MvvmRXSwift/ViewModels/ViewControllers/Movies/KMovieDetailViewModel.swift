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
            KCategory(title: "Info", isSelected: true),
            KCategory(title: "Trailers", isSelected: false),
            KCategory(title: "Photos", isSelected: false),
            KCategory(title: "Reviews", isSelected: false)
        ]
        menuItems.value = listMenu
    }
    
    func setUpViewController() {
        let vcTrailer = KMovieTrailerViewController.getViewController(fromAppStoryboard: .movie)
        vcTrailer.vmMovieTrailer.movieIdSelected = movieIdSelected
        
        //---
        let vcNowPlaying = KMovieViewController.getViewController(fromAppStoryboard: .movie)
        vcNowPlaying.typeMovie = .nowPlaying
        
        //---
        let vcUpComing = KMovieViewController.getViewController(fromAppStoryboard: .movie)
        vcUpComing.typeMovie = .upComing
        
        //---
        let vcTopRated = KMovieViewController.getViewController(fromAppStoryboard: .movie)
        vcTopRated.typeMovie = .topRated
        
        //---
        controllers  = [vcTrailer, vcNowPlaying, vcUpComing, vcTopRated]
    }
    
    func changedViewController(index: Int) {
        if index != 0 {
            let currentIndex = index - 1
            olderController.value = currentController.value
            currentController.value = controllers[currentIndex]
        } else {
            olderController.value = controllers[0]
            currentController.value = nil
        }
    }
}
