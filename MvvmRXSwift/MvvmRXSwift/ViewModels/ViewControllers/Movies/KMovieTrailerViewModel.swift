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
    
    var movieIdSelected: Int?
    
    
    
    
    func getData(){
        guard let id = movieIdSelected else {
            print("KMovieTrailerViewModel id movie is not available")
            return
        }
        getTrailer(movieId: id)
    }
    
    private func getTrailer(movieId: Int){
        let trailer = KMovieAPI.getTrailler(movieId: movieId)
        trailer.subscribe(onNext: { [unowned self] reponse in
            self.trailerResponse.value = reponse
        }).addDisposableTo(bag)
    }
    
}
