//
//  KAPIParameter.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/10/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation


protocol KAPIParameter {
    func propertyIgnored() -> [String]
}

extension KAPIParameter {
    func toParameter() -> [String: Any] {
        var parameter:  [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        
        for (key, value) in mirror.children {
            guard let _key = key  else { continue }
            
            if !propertyIgnored().contains(_key) {
                parameter[_key] = value
            }
        }
        
        return parameter
    }
}
