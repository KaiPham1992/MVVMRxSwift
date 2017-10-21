//
//  KMoviePopularViewModel.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

class KMovieViewModel {
    let bag = DisposeBag()
    var movieResponse = Variable<KMovieResponse?>(nil)
    var errorMessage = PublishSubject<String?>()
    
    var page = Variable<Int?>(nil) //--- nil to skip the first time subcribe
    
    //-- to check before get movies
    var typeMovie: KMovieType = KMovieType.popular
    
    
    /**
     1. set type movie again
     2. check genres if nil load genres, then load movie
     3. page == 1 & subscribe page. onNext load movie
    */
    init(typeMovie: KMovieType = KMovieType.popular){
        self.typeMovie = typeMovie
        if appMovieGenres.isEmpty {
            getGenresMovie()
        } else {
            page.value = 1
        }
        
        page.asObservable().subscribe(onNext: { [unowned self] _page in
            guard let currentPage = _page else { return }
            self.getMovies(page: currentPage)
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
extension KMovieViewModel {
    /**
     1. only show indicator when page == 1 => isLoading = true
     2. input is kind of movie (popular, top rated, now playing, up comming)
     3. get movies from kind of movies
     
    */
    
    func getMovies(page: Int) {
        var movies: Observable<KMovieResponse>!
        
        switch typeMovie {
        case .popular:
            movies = KMovieAPI.getMoviesPopular(page: page)
            break
        case .topRated:
            movies = KMovieAPI.getMoviesTopRate(page: page)
            break
        case .nowPlaying:
            movies = KMovieAPI.getMoviesNowPlaying(page: page)
            break
        case .upComing:
            movies = KMovieAPI.getMoviesUpcoming(page: page)
            break
        }
        
        if page == 1 {
            movies = movies.showProgressIndicator()
        }
        //-- subscribe success
        movies.subscribe(onNext: { [unowned self] reponse in
            //-- converter genreIds to genres (have id, name)
            let newResponse = reponse
            if !appMovieGenres.isEmpty {
                _ = newResponse.movies.map { $0.getGenres(genresInput: appMovieGenres)}
            }
            
            //---
            if page == 1 {
                self.movieResponse.value = newResponse
            } else {
                let tempMovieResponse = self.movieResponse.value
                tempMovieResponse?.movies.append(contentsOf: newResponse.movies)
                self.movieResponse.value = tempMovieResponse
            }
            }, onError: { [unowned self] error in
                self.errorMessage.onNext(error.localizedDescription)
            })
        .addDisposableTo(bag)
    }
    
    //--- get genres
    
    func getGenresMovie(){
        let genres = KMovieAPI.getGenresMovie()
        genres.subscribe(onNext: { [unowned self] genreResponse in
            appMovieGenres = genreResponse.genres
            
            //---
            self.page.value = 1
            
            }, onError: { error in
                self.page.value = 1
        })
        .addDisposableTo(bag)
    }
}
