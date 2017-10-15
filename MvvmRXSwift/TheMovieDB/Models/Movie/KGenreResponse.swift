//
//  KGenres.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/14/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import ObjectMapper



class KGenreResponse: KBaseModel {
    var genres = [KGenre]()
    
    required init?(map: Map) {
        super.init(map: map)
        self.genres <- map["genres"]
    }
}

//---
class KGenre: KBaseModel {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.name <- map["name"]
    }
}
