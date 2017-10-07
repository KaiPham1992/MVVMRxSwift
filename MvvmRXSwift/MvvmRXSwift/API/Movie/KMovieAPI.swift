//
//  KMovieAPI.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

class KMovieAPI {
    class func getMoviesPopular(page: Int) -> Observable<KMovieResponse> {
        print("getMoviesPopular in KMovieAPI \(page)")
        return KAPIHelper.fetch(target: .getPopular(page: page), KMovieDocument.self, KMovieResponse.self)
    }
    
    class func getMoviesTopRate(page: Int) -> Observable<KMovieResponse> {
        print("getMoviesTopRate in KMovieAPI \(page)")
        return KAPIHelper.fetch(target: .getTopRate(page: page), KMovieDocument.self, KMovieResponse.self)
    }
    
    class func getMoviesNowPlaying(page: Int) -> Observable<KMovieResponse> {
        print("getMoviesNowPlaying in KMovieAPI \(page)")
        return KAPIHelper.fetch(target: .getNowPlaying(page: page), KMovieDocument.self, KMovieResponse.self)
    }
    class func getMoviesUpcoming(page: Int) -> Observable<KMovieResponse> {
          print("getMoviesUpcoming in KMovieAPI \(page)")
        return KAPIHelper.fetch(target: .getUpcoming(page: page), KMovieDocument.self, KMovieResponse.self)
    }
    
    class func getGenresMovie() -> Observable<KGenreResponse> {
        print("getGenresMovie <-> in KMovieAPI)")
        return KAPIHelper.fetch(target: .getGenres(), KMovieDocument.self, KGenreResponse.self)
    }
    
    //--- get detail 
    
    class func getDetailMovie(movieId: Int) -> Observable<KMovie> {
        print("getDetailMovie in KMovieAPI \(movieId)")
        return KAPIHelper.fetch(target: .getDetail(movieId: movieId), KMovieDocument.self, KMovie.self)
    }
}

//--- MARK: Trailer, image, review, discussion ...
extension KMovieAPI {
    class func getTrailler(movieId: Int) -> Observable<KTrailerReponse> {
        print("getTrailler : \(movieId)")
        return KAPIHelper.fetch(target: .getTrailers(movieId: movieId), KMovieDocument.self, KTrailerReponse.self)
    }
    
    class func getImages(movieId: Int) -> Observable<KImageMovie> {
        print("getImages : \(movieId)")
        return KAPIHelper.fetch(target: .getImages(moviedId: movieId), KMovieDocument.self , KImageMovie.self)
    }
    
    
}
