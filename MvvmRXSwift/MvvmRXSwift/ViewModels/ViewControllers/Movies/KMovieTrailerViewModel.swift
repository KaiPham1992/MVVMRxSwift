//
//  KMovieTrailerViewModel.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/18/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import RxSwift

class KMovieTrailerViewModel {
    let bag = DisposeBag()
    var trailerResponse = Variable<KTrailerReponse?>(nil)
    var errorMessage = PublishSubject<String?>()
    var isLoading = Variable<Bool>(false)
    
    
    //---
    var streamMap = Variable<[FormatStreamMap]>([])
    var youtubeId = Variable<String?>(nil)
    
    var movieIdSelected: Int?
    
    func getData(){
        guard let id = movieIdSelected else {
            print("KMovieTrailerViewModel id movie is not available")
            return
        }
        getTrailer(movieId: id)
        
        //--- get video when have youtube id
        
        youtubeId.asObservable().subscribe(onNext: { [unowned self] id in
            guard let _id = id else { return }
            self.getVideo(youtubeId: _id)
        }).addDisposableTo(bag)
    }
    
    private func getTrailer(movieId: Int){
        let trailer = KMovieAPI.getTrailler(movieId: movieId)
        trailer.subscribe(onNext: { [unowned self] reponse in
            self.trailerResponse.value = reponse
        }).addDisposableTo(bag)
    }
    
    func getVideo(youtubeId: String){
        isLoading.value = true
        let video = KAPIHelper.getVideoYoutube(youtubeId: youtubeId)
       
        video.subscribe(onNext: { [unowned self] streamMap in
            self.isLoading.value = false
            self.streamMap.value = streamMap
            KPlayerVideoHelper.shared.showVideoUrl(url: streamMap[0].url)
        })
        .addDisposableTo(bag)
        
        //---
        video.subscribe(onError: { error in
            print(error.localizedDescription)
        }).addDisposableTo(bag)
    }
    
    
}
