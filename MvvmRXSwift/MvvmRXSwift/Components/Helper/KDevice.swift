//
//  KDevice.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import Device



class KDevie {
    class func getTypeDevice() -> TypeDevice {
        //        switch Device.version() {
        //        case .iPhone4, .iPhone4S, .iPhone5, .iPhone5C,.iPhone5S:
        //            return TypeDevice.SMALL
        //        default:
        //            return TypeDevice.NORMAL
        //        }
        
        switch Device.size() {
        case .screen3_5Inch, .screen4Inch:
            return TypeDevice.SMALL
        default:
            return TypeDevice.NORMAL
        }
    }
}
