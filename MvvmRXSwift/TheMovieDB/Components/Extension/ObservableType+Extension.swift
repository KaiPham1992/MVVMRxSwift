//
//  ObservableType+Extension.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/26/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import RxSwift

extension ObservableType {
    public func showProgressIndicator() -> Observable<Self.E> {
        return self.do( onError: {_ in
            print("Dismiss onError progress")
            KProgessHelper.shared.hideIndicator()
        }, onCompleted: {_ in
            print("Dismiss onCompleted progress")
            KProgessHelper.shared.hideIndicator()
        }, onSubscribe: {_ in
            print("Show progress")
            KProgessHelper.shared.showIndicator()
        })
    }
}
