//
//  KReview.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//


import ObjectMapper

class KReview : KBaseModel {
    var id: String?
    var author: String?
    var content: String?
    var url: String?
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.author <- map["author"]
        self.content <- map["content"]
        self.url <- map["url"]
    }
}
