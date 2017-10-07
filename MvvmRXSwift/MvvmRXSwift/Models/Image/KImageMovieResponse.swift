//
//  KImageMovieResponse.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/2/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KImageMovieResponse: KBaseModel {
    var backdrops = [KImageMovie]()
    var posters = [KImageMovie]()
    var id: Int?
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.backdrops <- map["backdrops"]
        self.posters <- map["posters"]
    }
}
