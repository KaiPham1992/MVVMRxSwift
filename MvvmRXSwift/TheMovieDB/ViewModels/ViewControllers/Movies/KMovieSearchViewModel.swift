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
    func loadMoreMovie()
    func refreshMovie()
}

internal protocol KMovieSearchViewModelOutputs {
    var movieResponse: Variable<KMovieResponse?> { get }
    var errorMessage: Variable<String> { get }
    
   
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
    var errorMessage: Variable<String> =  Variable<String>("")
    
    init() {
        self.page.asObservable().skip(1).subscribe(onNext: { _ in
            self.searchMovie()
        }).addDisposableTo(bag)
        
        btnSearchTapped.subscribe(onNext: { _ in
            self.page.value = 1
        }).addDisposableTo(bag)
    }
    
    func searchMovie() {
        guard let _page = page.value, let _key = keySearch.value else { return }
        
        var searchObservable =  KMovieAPI.searchMovie(page: _page, key: _key)
        
        if _page == 1 {
            self.movieResponse.value = nil
            searchObservable = searchObservable.showProgressIndicator()
        }
        
        searchObservable
            .subscribe(onNext: { [unowned self] newResponse in
            if self.page.value == 1 {
                self.movieResponse.value = newResponse
            } else {
                let tempMovieResponse = self.movieResponse.value
                tempMovieResponse?.movies.append(contentsOf: newResponse.movies)
                self.movieResponse.value = tempMovieResponse
            }
            }, onError: { error in
                self.errorMessage.value = error.localizedDescription
            })
            .addDisposableTo(bag)
    }
    
    func loadMoreMovie(){
        guard let _page = self.page.value else { return }
        self.page.value = _page + 1
    }
    
    func refreshMovie() {
        self.page.value = 1
    }
}
