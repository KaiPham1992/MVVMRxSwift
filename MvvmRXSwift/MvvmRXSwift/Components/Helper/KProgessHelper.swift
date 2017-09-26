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
        DispatchQueue.main.async {
            self.vLoading.showActivityIndicator()
        }
    }
    
    func hideIndicator(){
        DispatchQueue.main.async {
            self.vLoading.hideActivityIndicator()
        }
        
    }
}
