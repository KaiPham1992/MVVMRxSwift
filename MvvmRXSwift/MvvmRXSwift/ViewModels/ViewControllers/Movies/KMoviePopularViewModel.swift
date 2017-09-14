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
    var genres = PublishSubject<KGenreResponse?>()
    var errorMessage = PublishSubject<String?>()
    
    init(){
        if golobalGenres.count == 0 {
            getGrenresMovie()
        } else {
            getMoviesPopular(page: 1)
        }
    }
    
    private func getMoviesPopular(page: Int) {
        let movies = KMovieAPI.getMoviesPopular(page: page)
        movies.subscribe(onNext: { [unowned self] reponse in
            self.movieResponse.onNext(reponse)
        })
        .addDisposableTo(bag)
    }
    
    private func getGrenresMovie(){
        let genres = KMovieAPI.getGenresMovie()
        genres.subscribe(onNext: { [unowned self] genreResponse in
            golobalGenres = genreResponse.genres
            
            //---
            self.getMoviesPopular(page: 1)
            
            }, onError: { error in
                self.getMoviesPopular(page: 1)
        })
        .addDisposableTo(bag)
    }
}
