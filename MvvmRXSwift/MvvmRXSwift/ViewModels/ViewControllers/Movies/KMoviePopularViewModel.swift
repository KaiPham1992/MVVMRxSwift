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
    var movieResponse = Variable<KMovieResponse?>(nil)
    var genres = PublishSubject<KGenreResponse?>()
    var errorMessage = PublishSubject<String?>()
    
    var isLoading = PublishSubject<Bool>()
    var page = Variable<Int?>(nil) //--- nil to skip the first time subcribe
    
    init(){
        if golobalGenres.count == 0 {
            getGrenresMovie()
        } else {
            page.value = 1
        }
        
        page.asObservable().subscribe(onNext: { [unowned self] _page in
            guard let currentPage = _page else { return }
            self.getMoviesPopular(page: currentPage)
        }).addDisposableTo(bag)
    }
    
    
    func refreshMovies(){
        page.value = 1
    }
    
    func loadMoreMovies(){
        if page.value != nil {
            page.value = page.value! +  1
        }
    }
}

//--- MARK: Handle API
extension KMoviePopularViewModel {
    /**
     1. only show indicator when page == 1 => isLoading = true
    */
    
    func getMoviesPopular(page: Int) {
        if page == 1 {
            isLoading.onNext(true)
        }
       
        let movies = KMovieAPI.getMoviesPopular(page: page)
        movies.subscribe(onNext: { [unowned self] reponse in
            self.isLoading.onNext(false)
            
            if page == 1 {
                self.movieResponse.value = reponse
            } else {
                let tempMovieResponse = self.movieResponse.value
                tempMovieResponse?.movies.append(contentsOf: reponse.movies)
                self.movieResponse.value = tempMovieResponse
            }
        })
        .addDisposableTo(bag)
    }
    
    func getGrenresMovie(){
        let genres = KMovieAPI.getGenresMovie()
        genres.subscribe(onNext: { [unowned self] genreResponse in
            golobalGenres = genreResponse.genres
            
            //---
            self.page.value = 1
            
            }, onError: { error in
                self.page.value = 1
        })
        .addDisposableTo(bag)
    }
}
