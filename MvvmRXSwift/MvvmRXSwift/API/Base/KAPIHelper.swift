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

class KAPIHelper {
    
    /**
     1. input target type include all info to execute request
     2. out put type Model
     3. use MoyaProvider to request
    */
    
    class func fetch<T: TargetType, U: KBaseModel>(target: T, _: T.Type, _: U.Type) -> Observable<U> {
        let observable = Observable<U>.create { observer in
            let provider = MoyaProvider<T>()
            
            provider.request(target) { (event) in
                switch event {
                case .success(let response):
                    //--- check error 401/404 
                    if response.statusCode != 200 {
                        let json = JSON(data: response.data)
                        var message = ""
                        if let _message = json["status_message"].string {
                            message = _message
                        }
                        observer.onError(NSError(domain: message, code: response.statusCode, userInfo:nil))
                    } else {
                        let json = JSON(data: response.data)
                        let map = Map(mappingType: .fromJSON, JSON: json.dictionaryObject!)
                        if let objectRespond =  U(map: map) {
                            observer.onNext(objectRespond)
                            observer.onCompleted()
                        } else {
                            observer.onError(NSError(domain: "Invalid respond", code: 500, userInfo:nil))
                        }
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
        return observable.shareReplay(1)
    }
    
    //-- get info video youtube
    class func getVideoYoutube(youtubeId: String) -> Observable<[FormatStreamMap]> {
        let urlStr = BASE_VIDEO_YOUTUBE.replacingOccurrences(of: "{id}", with: youtubeId)
        let observable = Observable<[FormatStreamMap]>.create({ observer in
            if let url = URL(string: urlStr) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        observer.onError(error!)
                    } else {
                        let strData = String.init(data: data!, encoding: String.Encoding.utf8)!
                        do {
                            let stream = try FormatStreamMapFromString(strData).filter {$0.type.contains("video/mp4")}
                            observer.onNext(stream)
                        } catch let error {
                            observer.onError(error)
                        }
                    }
                }).resume()
            } else {
                observer.onError(NSError(domain: "Url video failed !", code: 500, userInfo: nil))
            }
             return Disposables.create()
        })
         return observable.shareReplay(1)
    }
}
