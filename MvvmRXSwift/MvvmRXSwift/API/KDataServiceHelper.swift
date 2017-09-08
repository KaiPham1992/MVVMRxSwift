//
//  KDataServiceHelper.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya
import RxSwift
import SwiftyJSON


class KDataServiceHelper {
    func fetch<T: TargetType, U: KBaseModel>(target: T, _: T.Type, _: U.Type) -> Observable<U> {
        let observable = Observable<U>.create { observer in
            let provider = MoyaProvider<T>()
            
            provider.request(target) { (event) in
                switch event {
                case .success(let response):
                    let json = JSON(data: response.data)
                    if let objectRespond =  U(JSON: json.dictionaryObject!) {
                        observer.onNext(objectRespond)
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "Invalid respond", code: 500, userInfo:nil))
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
        
        return observable.shareReplay(1)
    }
}
