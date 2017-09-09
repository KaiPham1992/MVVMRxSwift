//
//  KMoviePopularViewModel.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

class KMoviePopularViewModel {
    let bag = DisposeBag()
    var movieResponse = PublishSubject<KMovieResponse?>()
    var errorMessage = PublishSubject<String?>()
    
    init(){
        getMoviesPopular(page: 1)
    }
    
    
    func getMoviesPopular(page: Int) {
        let movies = KMovieAPI.getMoviesPopular(page: page)
//        movies.subscribe(onNext: { movieResponseValue in
//            self.movieResponse.value = movieResponseValue
//        })
//        .addDisposableTo(bag)
        
        movies.subscribe(onNext: { reponse in
            self.movieResponse.onNext(reponse)
        })
        .addDisposableTo(bag)
    }
}
