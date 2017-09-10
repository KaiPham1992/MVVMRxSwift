//
//  KMoviePopularViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMoviePopularViewController: KBaseViewController {
    
    private var vmPopularMovie = KMoviePopularViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addButtonToNavigation(image: KImage.imgCategory, style: .left, action: nil)
    }
    
    func bindUI() {
        vmPopularMovie.movieResponse.asObservable()
            .subscribe(onNext: { movieResponse in
                print(movieResponse)
            })
            .addDisposableTo(bag)
        
        
    }
}
