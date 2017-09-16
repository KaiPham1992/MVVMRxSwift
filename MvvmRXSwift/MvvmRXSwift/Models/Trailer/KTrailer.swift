//
//  KTrailer.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KTrailer : KBaseModel {
    var id: Int?
    var key: String?
    var name: Bool?
    var site: String?
    var size: String?
    var type: [Int]?
    var iso_639_1: String?
    var iso_3166_1: String?
    
    //---
    var urlVideo: String = ""
    

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
        
        if let _key = self.key, let _id = self.id {
            self.urlVideo = BASE_VIDEO.replacingOccurrences(of: "{key}", with: _key).replacingOccurrences(of: "{id}", with: _id.description)
        }
        

    }
}
