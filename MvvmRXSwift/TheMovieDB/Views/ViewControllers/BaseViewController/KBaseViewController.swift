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


class KBaseViewController: UIViewController {
    let bag = DisposeBag()
    
//    static func getViewController(storyboard: UIStoryboard = UIStoryboard.movieStoryBoard()) -> UIViewController {
//        let storyboardId = String(describing: self)
//        return storyboard.instantiateViewController(withIdentifier: storyboardId)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTabbar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = KColor.background
        setupNavigation()
        
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
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
            btn.contentHorizontalAlignment = .left
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
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
            KProgessHelper.shared.hideIndicator()
            navigation.popViewController(animated: true)
        }
    }
    
    func btnCloseTapped(){
        KProgessHelper.shared.hideIndicator()
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
//--MARK: handle keyboard

extension KBaseViewController {
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification: Notification){
        
    }
    func keyboardWillHide(notification: Notification) {
        
    }
}


//--- MARK: handle navigationbar & tabbar
extension KBaseViewController {
    func showTabbar(){
        self.tabBarController?.tabBar.isHidden = false
    }

    func hideTabbar(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func removeController(controller: UIViewController){
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    func insertController(controller: UIViewController, vContent: UIView) {
        //---
        self.addChildViewController(controller)
        controller.view.frame = vContent.bounds
        vContent.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }

}
