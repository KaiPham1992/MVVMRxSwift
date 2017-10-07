//
//  KImageMovie.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/2/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KImageMovie: KBaseModel {
    var aspectRatio: Double?
    var urlPhoto: String?
    var height: Double?
    var voteAverage: Int?
    var voteCount: Int?
    var width: Double?
    
    required init?(map: Map) {
        super.init(map: map)
        self.aspectRatio <- map["aspect_ratio"]
        self.urlPhoto <- map["file_path"]
        self.height <- map["height"]
        self.voteAverage <- map["vote_average"]
        self.voteCount <- map["vote_count"]
        self.width <- map["width"]
        if self.urlPhoto != nil {
            self.urlPhoto = "\(BASE_IMAGE_URL)\(self.urlPhoto!)"
        }
        
    }
}
