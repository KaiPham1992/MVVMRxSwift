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
    var isLoading = Variable<Bool>(false)
    
    var menuItems = Variable<[KCategory]>([])
    
    var bag = DisposeBag()
    
    var movieIdSelected: Int?
    func getData() {
        //---
        setUpMenuItems()
        getDetailMovie()
    }
    
    func getDetailMovie(){
        guard let id = movieIdSelected else { return }
        isLoading.value = true
        let movieDetail = KMovieAPI.getDetailMovie(movieId: id)
        
        //-- when success
        movieDetail.subscribe(onNext: { [unowned self] movie in
           self.isLoading.value = false
           self.movieSelected.value = movie
        }).addDisposableTo(bag)
        
        //-- when error
        movieDetail.subscribe(onError: { [unowned self] mess in
            self.isLoading.value = false
            self.errorMessage.value = mess.localizedDescription
        }).addDisposableTo(bag)
    }
    
    func setUpMenuItems(){
        let listMenu: [KCategory] = [
            KCategory(title: "Info", isSelected: true),
            KCategory(title: "Trailer", isSelected: false),
            KCategory(title: "Review", isSelected: false),
            KCategory(title: "Discussions", isSelected: false)
        ]
        
        menuItems.value = listMenu
    }

}
