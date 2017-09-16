//
//  String+Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

extension String {
    func toUrl() -> URL? {
        if let url = URL(string: self) {
            return url 
        }
        return nil
    }
    
}
