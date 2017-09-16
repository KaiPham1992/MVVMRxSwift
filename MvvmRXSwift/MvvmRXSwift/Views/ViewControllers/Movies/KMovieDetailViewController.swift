//
//  KMovieDetailViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieDetailViewController: KBaseViewController {
    
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    
    //---info
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbgenres: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbBudget: UILabel!
    @IBOutlet weak var lbRevenue: UILabel!
    @IBOutlet weak var lbVoteAverage: UILabel!
    @IBOutlet weak var vImbd: UIView!
    
    @IBOutlet weak var lbOverView: UILabel!
    
    
    //---menu
    @IBOutlet weak var vMenu: KMenuSlideTopView!
    
    
    var vmMovieDetail = KMovieDetailViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vmMovieDetail.getData()
        hideTabbar()
        setUpView()
        
        //---
        bindUI()
    }
    
    func setUpView(){
//        imgPoster.setBorder(cornerRadius: 5)
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addBackToNavigation()
    }
    
    func bindUI(){
        bindMenu()
        bindError()
        bindMovieDetail()
        bindLoading()
    }
}

//--- MARK: handle logics
extension KMovieDetailViewController {
    func bindMenu(){
        let menuObservable = vmMovieDetail.menuItems.asObservable()
        menuObservable.subscribe(onNext: { [unowned self] items in
            self.vMenu.listItem = items
            self.view.layoutIfNeeded()
        }).addDisposableTo(bag)
    }
    
    func bindError(){
        vmMovieDetail.errorMessage.asObservable().skip(1).subscribe(onNext: { [unowned self] mess in
            self.showErrorMessage(errorMessage: mess)
        }).addDisposableTo(bag)
    }
    
    func bindMovieDetail(){
        vmMovieDetail.movieSelected.asObservable().subscribe(onNext: { [unowned self] movie in
            guard let _movie = movie else { return }
            self.showInfoMovie(movie: _movie)
            
        }).addDisposableTo(bag)
    }
    
    func bindLoading(){
        vmMovieDetail.isLoading.asObservable().subscribe(onNext: { [unowned self] isLoading in
            isLoading == true  ? self.showActivityIndicator() : self.hideActivityIndicator()
        }).addDisposableTo(bag)
    }
    
    //---
    func showInfoMovie(movie: KMovie){
        imgPoster.setBorder(borderWidth: 1, borderColor: KColor.lineColor, cornerRadius: 5)
        imgBackdrop.setBorder(borderWidth: 1, borderColor: KColor.lineColor, cornerRadius: 5)
        imgBackdrop.sd_setImage(with: movie.backdropPath?.toUrl(), placeholderImage: KImage.imgLoadingLandscape)
        
        imgPoster.sd_setImage(with: movie.posterPath?.toUrl(), placeholderImage: KImage.imgLoadingPortrait)
        
        //-- info 
        lbTitle.text = movie.title
        lbgenres.text = movie.genresToString()
        
        
        if let status = movie.status, let time =  movie.runtime?.toHHMM(){
            lbTime.text = "\(status): \(time)"
        }
        
        
        if let average = movie.voteAverage?.description {
            lbVoteAverage.text = "\(average) / 10"
        }
        vImbd.setBorder(cornerRadius: 4)
        
        lbOverView.text = movie.overview
        
        
        //-- 
        if let budget = movie.budget?.toCurrency() {
            lbBudget.text = "Budget: \(budget)"
        }
        
        if let revenue = movie.revenue?.toCurrency() {
            lbRevenue.text = "Revenue: \(revenue)"
        }
    }
}


