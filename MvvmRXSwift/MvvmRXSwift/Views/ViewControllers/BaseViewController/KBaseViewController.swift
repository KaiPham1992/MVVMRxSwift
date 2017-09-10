//
//  BaseViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit
import RxSwift

//MARK: Style Navigation Bar

enum StyleNavigation {
    case left
    case right
}

class KBaseViewController: UIViewController {
    let bag = DisposeBag()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = KColor.background
        setupNavigation()
        setupActivityIndicator()
        
        //---detect Keyboard
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self , selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self , selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        
    }
    //MARK: Base navigation
    func setupNavigation(){
        //---
        self.navigationController?.navigationBar.barTintColor = KColor.navigationColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = KColor.background
    }
    
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?){
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self , action: _action, for: .touchUpInside)
        }
        
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    func addButtonTextToNavigation(title: String, style: StyleNavigation, action: Selector?){
        let btn = UIButton()
        btn.setAttributed(title: title, color: KColor.whiteColor, font: KFont.fontBold17)
        if let _action = action {
            btn.addTarget(self , action: _action, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func addBackToNavigation(){
        addButtonToNavigation(image: KImage.imgBack, style: .left, action: #selector(btnBackTapped))
    }
    
    func addCloseToNavigation(){
        addButtonToNavigation(image: KImage.imgClose, style: .left, action: #selector(btnCloseTapped))
    }
    
    func setTitle(title: String) {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        lb.font = KFont.fontBold17
        lb.text = title
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.textColor = KColor.whiteColor
        lb.sizeToFit()
        
        self.navigationItem.titleView = lb
    }
    
    func btnBackTapped(){
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func btnCloseTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: func base in view
    // hide key board
    func addGestureToRootView(){
        //--- add gesture to dismiss keyboard
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(rootViewTapped)))
    }
    
    func rootViewTapped(){
        self.view.endEditing(true)
    }
    
}
// MARK: Indicator
extension KBaseViewController {
    func setupActivityIndicator(){
        blackView.addSubview(activityIndicator)
        activityIndicator.anchorCenterSuperview()
        self.blackView.addSubview(lbUpLoading)
        lbUpLoading.anchorCenterXToSuperview()
        lbUpLoading.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20).isActive = true
    }
    
    func showActivityIndicator(){
        self.dismissKeyboard()
        self.lbUpLoading.isHidden = true
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.fillSuperview()
            activityIndicator.startAnimating()
        }
    }
    
    func showActivityIndicatorHaveProgess(){
        self.dismissKeyboard()
        self.lbUpLoading.isHidden = false
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.fillSuperview()
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator(){
        blackView.removeFromSuperview()
    }
    
}

//--MARK: handle keyboard

extension KBaseViewController {
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification: Notification){
        
    }
    func keyboardWillHide(notification: Notification){
    }
}
