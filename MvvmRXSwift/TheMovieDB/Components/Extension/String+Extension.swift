//
//  String+Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

postfix operator &

postfix func & <T>(s: T?) -> String {
    return (s == nil) ? "" : "\(s!)"
}

postfix func & <T>(s: T) -> String {
    return "\(s)"
}


postfix operator *
postfix func *<T>(s: T?) -> Int {
    return (s == nil) ? 0: Int("\(s!)")!
}

extension String {
    func toUrl() -> URL? {
        if let url = URL(string: self) {
            return url 
        }
        return nil
    }
    
}
