//
//  KProductionCompany.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import ObjectMapper

class KCompany: KBaseModel {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        super.init(map: map)
        self.id <- map["id"]
        self.name <- map["name"]
    }
}
