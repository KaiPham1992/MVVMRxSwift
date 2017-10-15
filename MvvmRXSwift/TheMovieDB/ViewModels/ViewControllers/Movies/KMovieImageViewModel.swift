//
//  KImageViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/7/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import RxSwift

class KMovieImageViewModel {
    var movieIdSelected: Int?
    var bag = DisposeBag()
    var images = Variable<[KImageMovie]>([])
    
    //---
    func getData(){
        guard let id = movieIdSelected else { return }
        getImages(moiveId: id)
    }
    //---
    private func getImages(moiveId: Int){
        let imagesObserver = KMovieAPI.getImages(movieId: moiveId).showProgressIndicator()
        imagesObserver.subscribe(onNext: { [unowned self] imageResponse in
            self.images.value = imageResponse.backdrops
        }).addDisposableTo(bag)
    }
}
