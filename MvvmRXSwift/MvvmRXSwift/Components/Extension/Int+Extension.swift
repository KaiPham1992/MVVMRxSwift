//
//  Int_Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

extension Int {
    func toHHMM() -> String {
        let hours = self / 60
        let minutes = self - (hours * 60)
        
        if hours > 0 {
            return "\(hours)h \(minutes) min"
        }
        return "\(minutes)min"
    }
    
    func toCurrency() -> String {
        var str = ""
        let number = self as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_CL") //-- dont have decimal point
        if let _str = formatter.string(from: number) {
            str = _str
        }
        
        return str
    }
}
