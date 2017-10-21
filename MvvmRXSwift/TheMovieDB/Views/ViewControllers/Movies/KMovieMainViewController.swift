//
//  KMovieMainViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/15/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieMainViewController: KBaseViewController {
    
    @IBOutlet weak var vMenu: KMenuSlideTopView!
    @IBOutlet weak var vContent: UIView!
    
    
    var vmMovieMain: KMovieMainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindUI()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addButtonToNavigation(image: KImage.imgCategory, style: .left, action: nil)
        setTitle(title: "The Movie DB")
        addButtonToNavigation(image: KImage.imgSearch, style: .right, action: #selector(btnSearchTapped))
    }
    
    func setUpView(){
        vmMovieMain = KMovieMainViewModel()
        vMenu.delegate = self
    }
    
    func bindUI(){
        bindMenu()
        bindCurrentController()
        bindOlderController()
    }
    
    func btnSearchTapped(){
       let vc = KMovieSearchViewController.getViewController(fromAppStoryboard: .movie)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//--- MARK: handle logics
extension KMovieMainViewController {
    func bindMenu(){
        let menuObservable = vmMovieMain.menuItems.asObservable()
        menuObservable.subscribe(onNext: { [unowned self] items in
            self.vMenu.listItem = items
            self.view.layoutIfNeeded()
        }).addDisposableTo(bag)
    }
    
    func bindCurrentController(){
        let currentObservable = vmMovieMain.currentController.asObservable()
        currentObservable.subscribe(onNext: { [unowned self] vc in
            guard let _vc = vc else { return }
            self.insertController(controller: _vc, vContent: self.vContent)
        }).addDisposableTo(bag)
    }
    
    func bindOlderController(){
        let currentObservable = vmMovieMain.olderController.asObservable()
        currentObservable.subscribe(onNext: { [unowned self] vc in
            guard let _vc = vc else { return }
            self.removeController(controller: _vc)
        }).addDisposableTo(bag)
    }
}


extension KMovieMainViewController: KMenuSlideTopViewDelegate {
    //-- change view when tap menu
    func itemMenuSelected(index: Int) {
        vmMovieMain.changedViewController(index: index)
    }
}
