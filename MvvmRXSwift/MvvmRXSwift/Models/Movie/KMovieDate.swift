//
//  KMovieDate.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import ObjectMapper

class KMovieDate: KBaseModel {
    var maximum: String?
    var minimum: String?
    
    required init?(map: Map) {
        super.init(map: map)
        self.maximum <- map["maximum"]
        self.minimum <- map["minimum"]
    }
}
