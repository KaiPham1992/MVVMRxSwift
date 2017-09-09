//
//  KMovieAPI.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import RxSwift

class KMovieAPI {
    class func getMoviesPopular(page: Int) -> Observable<KMovieResponse> {
        return KAPIHelper.fetch(target: .getPopular(page: page), KMovieDocument.self, KMovieResponse.self)
    }
}
