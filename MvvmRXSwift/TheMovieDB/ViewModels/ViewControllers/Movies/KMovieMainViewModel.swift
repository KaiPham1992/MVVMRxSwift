//
//  KMovieMainViewModel.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/15/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import RxSwift

class KMovieMainViewModel {
    var controllers = [UIViewController]()
    var menuItems = Variable<[KCategory]>([])
    
    var olderController = Variable<UIViewController?>(nil)
    var currentController = Variable<UIViewController?>(nil)
    
    init() {
        setUpViewController()
        setUpMenuItems()
    }
    
    func setUpViewController() {
        let vcPopular = KMovieViewController.getViewController(fromAppStoryboard: .movie)
        vcPopular.typeMovie = .popular
        
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
        controllers  = [vcUpComing, vcPopular, vcNowPlaying, vcTopRated]
        
        //---
        currentController.value = controllers[0]
    }
    
    func setUpMenuItems(){
        let listMenu: [KCategory] = [
            KCategory(title: "Up Coming", isSelected: true),
            KCategory(title: "Popular", isSelected: false),
            KCategory(title: "Now Playing", isSelected: false),
            KCategory(title: "Top Rated", isSelected: false)
        ]
        
        menuItems.value = listMenu
    }
    
    func changedViewController(index: Int) {
        olderController.value = currentController.value
        currentController.value = controllers[index]
    }
}
