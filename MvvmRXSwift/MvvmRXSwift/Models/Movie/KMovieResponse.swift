//
//  KMovieResponse.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieResponse: KBaseModel {
    var page: Int?
    var dates: KMovieDate?
    var totalPages: Int?
    var totalResult: Int?
    var movies: [KMovie]?
}
