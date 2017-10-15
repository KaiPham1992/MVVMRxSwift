//
//  UIButton+Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

extension UIButton {
    func setAttributed(title: String, color: UIColor, font: UIFont?, isUnderLine: Bool = false ) {
        var attr = NSAttributedString()
        if isUnderLine {
            attr = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font!, NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        } else {
            attr = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font!])
        }
        
        
        
        self.setAttributedTitle(attr, for: .normal)
    }
    
}
