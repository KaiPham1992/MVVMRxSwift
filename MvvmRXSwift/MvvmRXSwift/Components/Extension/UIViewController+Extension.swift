//
//  UIViewController+Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/15/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit



//--- MARK: Show alert
extension UIViewController {
    func showErrorMessage(errorMessage: String?) {
        guard  let _mes = errorMessage else { return }
        let alert = UIAlertController(title: "Error", message: _mes, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
}

//---MARK: Init
extension UIViewController {
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func getViewController(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self)
    }
}


//---MARK:  push, pop, dissmiss, present
extension UIViewController {
    
}
