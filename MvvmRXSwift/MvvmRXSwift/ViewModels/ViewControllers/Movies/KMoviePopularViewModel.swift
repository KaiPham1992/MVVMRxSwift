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
    var genreResponse = Variable<KGenreResponse?>(nil)
    var errorMessage = PublishSubject<String?>()
    
    var isLoading = PublishSubject<Bool>()
    var page = Variable<Int?>(nil) //--- nil to skip the first time subcribe
    
    init(){
        if genreResponse.value == nil {
            getGenresMovie()
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
        
        //-- subscribe success
        movies.subscribe(onNext: { [unowned self] reponse in
            self.isLoading.onNext(false)
            let newResponse = reponse
            if let _genres = self.genreResponse.value?.genres {
                _ = newResponse.movies.map { $0.getGenres(genresInput: _genres)}
            }
            
            if page == 1 {
                self.movieResponse.value = newResponse
            } else {
                let tempMovieResponse = self.movieResponse.value
                tempMovieResponse?.movies.append(contentsOf: newResponse.movies)
                self.movieResponse.value = tempMovieResponse
            }
        })
        .addDisposableTo(bag)
        
        //--- subscribe when error
        movies.subscribe(onError: { [unowned self] error in
            self.errorMessage.onNext(error.localizedDescription)
            self.isLoading.onNext(false)
        })
        .addDisposableTo(bag)
    }
    
    //--- get grenres
    
    func getGenresMovie(){
        let genres = KMovieAPI.getGenresMovie()
        genres.subscribe(onNext: { [unowned self] genreResponse in
            
            self.genreResponse.value = genreResponse
            
            //---
            self.page.value = 1
            
            }, onError: { error in
                self.page.value = 1
        })
        .addDisposableTo(bag)
    }
}
