//
//  KMovieParameterGetList.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/10/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieParameterGetList: KAPIParameter {
    
    var api_key: String = ""
    var page: Int = 0
    
    func propertyIgnored() -> [String] {
        return []
    }
    
    init(page: Int) {
        self.page = page
        self.api_key = API_KEY
    }
    
    

    
}
