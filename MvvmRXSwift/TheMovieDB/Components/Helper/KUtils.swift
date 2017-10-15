//
//  KUtils.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/26/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KProgessHelper {
    static let shared = KProgessHelper()
    var vLoading = KLoadingView()
    
    func showIndicator(){
        vLoading.showActivityIndicator()
    }
    
    func hideIndicator(){
        vLoading.hideActivityIndicator()
    }
}
