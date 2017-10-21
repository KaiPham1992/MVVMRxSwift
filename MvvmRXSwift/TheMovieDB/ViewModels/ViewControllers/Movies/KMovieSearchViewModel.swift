//
//  KMovieSearchViewModel.swift
//  TheMovieDB
//
//  Created by Kai on 10/21/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

internal protocol KMovieSearchViewModelInputs {
    var page: Variable<Int?> { get }
    var keySearch: Variable<String?> { get }
    var btnSearchTapped: PublishSubject<Bool> { get }
    func searchMovie()
}

internal protocol KMovieSearchViewModelOutputs {
    var movieResponse: Variable<KMovieResponse?> { get }
    var errorMessage: Variable<String?> { get }
    
   
}

internal protocol KMovieSearchViewModelType {
    var inputs: KMovieSearchViewModelInputs { get }
    var outputs: KMovieSearchViewModelOutputs { get }
}


internal final class KMovieSearchViewModel: KMovieSearchViewModelType,  KMovieSearchViewModelInputs, KMovieSearchViewModelOutputs{
    private let bag = DisposeBag()
    var inputs: KMovieSearchViewModelInputs { return self }
    var outputs: KMovieSearchViewModelOutputs { return self }
    
    var page: Variable<Int?> = Variable<Int?>(nil)
    var keySearch: Variable<String?> = Variable<String?>(nil)
    var btnSearchTapped: PublishSubject<Bool> = PublishSubject<Bool>()
    
    var movieResponse: Variable<KMovieResponse?> =  Variable<KMovieResponse?>(nil)
    var errorMessage: Variable<String?> =  Variable<String?>(nil)
    
    init() {
        self.page.value = 1
        
        btnSearchTapped.subscribe(onNext: { _ in
            self.searchMovie()
        }).addDisposableTo(bag)
    }
    
    func searchMovie() {
        let userInput = Observable.combineLatest(page.asObservable(), keySearch.asObservable()) { (page, key) -> (Int, String) in
            return (page*, key&)
        }
        
        _ = userInput.flatMapLatest { (arg) -> Observable<KMovieResponse> in
            let (page, key) = arg
            return KMovieAPI.searchMovie(page: page, key: key).showProgressIndicator()
        }.bind(to: movieResponse)
        
    
    
    }
}
