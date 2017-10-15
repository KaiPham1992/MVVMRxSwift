//
//  KMovieResponse.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import ObjectMapper

class KMovieResponse: KBaseModel {
    var page: Int?
    var dates: KMovieDate?
    var totalPages: Int?
    var totalResult: Int?
    var movies = [KMovie]()
    
    
    required init?(map: Map) {
        super.init(map: map)
        self.page <- map["page"]
        self.dates <- map["dates"]
        self.totalPages <- map["total_pages"]
        self.totalResult <- map["total_results"]
        self.movies <- map["results"]
    }
    
    
}
