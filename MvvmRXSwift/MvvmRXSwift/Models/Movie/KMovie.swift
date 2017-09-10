//
//  KMovie.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import ObjectMapper

class KMovie: KBaseModel {
    var id: Int?
    var posterPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.posterPath <- map["poster_path"]
        self.adult <- map["adult"]
        self.overview <- map["overview"]
        self.releaseDate <- map["release_date"]
        self.genreIds <- map["genre_ids"]
        self.originalTitle <- map["original_title"]
        self.originalLanguage <- map["original_language"]
        self.title <- map["title"]
        self.backdropPath <- map["backdrop_path"]
        self.popularity <- map["popularity"]
        self.voteCount <- map["vote_count"]
        self.video <- map["video"]
        self.voteAverage <- map["vote_average"]
        
        if self.posterPath != nil {
            self.posterPath = "\(BASE_IMAGE_URL)\(self.posterPath!)"
        }
        
        if self.backdropPath != nil {
            self.backdropPath = "\(BASE_IMAGE_URL)\(self.backdropPath!)"
        }
        
    }
    
}
