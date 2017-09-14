//
//  KMovieDocument.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import Moya

enum KMovieDocument {
    case getPopular(page: Int)
    case getTopRate(page: Int)
    case getGenres()
}

extension KMovieDocument: TargetType {
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }

    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getPopular(_):
            return "/movie/popular"
        case .getTopRate(_):
            return "/movie/top_rated"
        case .getGenres():
            return "/genre/movie/list"
        }
    }

    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }

    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    /// The parameters to be encoded in the request.
    var parameters: [String : Any]? {
        switch self {
        case .getPopular(let page):
            return KMovieParameterGetList(page: page).toParameter()
        case .getTopRate(let page):
            return KMovieParameterGetList(page: page).toParameter()
        case .getGenres():
            return ["api_key": API_KEY]
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
