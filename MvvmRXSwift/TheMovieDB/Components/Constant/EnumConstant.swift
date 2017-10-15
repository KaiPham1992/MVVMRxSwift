//
//  EnumConstant.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/7/17.
//  Copyright © 2017 Kai. All rights reserved.
//


enum StyleNavigation {
    case left
    case right
}


enum TypeDevice {
    case SMALL
    case NORMAL
    case BIG
    
}

enum KMovieType: String {
    case popular
    case topRated
    case nowPlaying
    case upComing
}


enum AppStoryboard: String {
    case movie         = "Movie"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyBoardId = (viewControllerClass as UIViewController.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyBoardId) as! T
    }
    
}
