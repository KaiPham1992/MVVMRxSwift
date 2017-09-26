//
//  KLoadingView.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/26/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KLoadingView: KBaseView {
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.startAnimating()
        return aiv
    }()
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = KColor.backgroundIndicator
        
        return view
    }()
    
    let lbUpLoading: UILabel = {
        let lb = UILabel()
        lb.font = KFont.fontRegular15
        lb.textAlignment = .center
        lb.textColor = KColor.whiteColor
        
        return lb
    }()
    
    
    override func setupViews() {
        blackView.addSubview(activityIndicator)
        activityIndicator.centerSuperview()
        blackView.addSubview(lbUpLoading)
        lbUpLoading.centerXToSuperview()
        lbUpLoading.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20).isActive = true
    }
    
    func showActivityIndicator(){
//        if let vc = UIApplication.topViewController() {
//            vc.view.endEditing(true)
//        }
//        self.lbUpLoading.isHidden = true
//        if let window = UIApplication.shared.keyWindow {
//            window.addSubview(blackView)
//            blackView.fillSuperview()
//            activityIndicator.startAnimating()
//        }
    }
    
    func showActivityIndicatorHaveProgess(){
//        if let vc = UIApplication.topViewController() {
//            vc.view.endEditing(true)
//        }
//        self.lbUpLoading.isHidden = false
//        if let window = UIApplication.shared.keyWindow {
//            window.addSubview(blackView)
//            blackView.fillSuperview()
//            activityIndicator.startAnimating()
//        }
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
//            self.blackView.removeFromSuperview()
        }
    }
}
