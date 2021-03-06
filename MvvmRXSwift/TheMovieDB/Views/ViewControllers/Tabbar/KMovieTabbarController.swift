//
//  KMovieTabbarController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/15/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        let vcMovie = KMovieMainViewController.getViewController(fromAppStoryboard: .movie)
        vcMovie.tabBarItem = setUpBarItem(title: "Movie", normalImage: KImage.imgTabMovieNomarl, selectedImage: #imageLiteral(resourceName: "movie"))
        
        let ncMovie = UINavigationController(rootViewController: vcMovie)
        
        self.viewControllers = [ncMovie]
    }
    
    func setUpBarItem(title: String?, normalImage: UIImage?, selectedImage: UIImage?) -> UITabBarItem {
        let barItem = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        
        return barItem
    }
}
