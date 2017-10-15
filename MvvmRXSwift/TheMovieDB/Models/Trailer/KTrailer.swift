//
//  KTrailer.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KTrailer : KBaseModel {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: [Int]?
    var iso_639_1: String?
    var iso_3166_1: String?
    
    //---
    var thumbnail: String?
    

    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.key <- map["key"]
        self.name <- map["name"]
        self.site <- map["site"]
        self.size <- map["size"]
        self.type <- map["type"]
        self.iso_639_1 <- map["iso_639_1"]
        self.iso_3166_1 <- map["iso_3166_1"]
        
        if let _key = key {
            self.thumbnail = BASE_IMAGE_YOUTUBE.replacingOccurrences(of: "{id}", with: _key)
        }
        

    }
}
