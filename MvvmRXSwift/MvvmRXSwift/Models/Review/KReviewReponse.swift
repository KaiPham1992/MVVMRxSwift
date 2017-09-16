//
//  KReviewReponse.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KReviewReponse: KBaseModel {
    var id: Int?
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    
    var reviews = [KReview]()
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.page <- map["page"]
        self.totalPages <- map["total_pages"]
        self.totalResults <- map["total_results"]
        self.reviews <- map["results"]
    }
}
