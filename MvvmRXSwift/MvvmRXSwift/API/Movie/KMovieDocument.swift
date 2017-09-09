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
}

extension KMovieDocument: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }

    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getPopular(_):
            return "movie/popular"
        case .getTopRate(_):
            return "movie/top_rated"
        }
    }

    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }

    
}
