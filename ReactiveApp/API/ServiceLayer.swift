//
//  ServiceLayer.swift
//  ReactiveApp
//
//  Created by TungImac on 11/2/20.
//

import Foundation
import Moya
import RxSwift
let mock = true
class ServiceLayer {
  static let shared = ServiceLayer(mock: true)
  let provider: MoyaProvider<ApiRouter>!
  init(mock: Bool, delayMock: Double = 1) {
    if delayMock <= 0.0001 {
      provider = MoyaProvider<ApiRouter>(stubClosure: MoyaProvider.immediatelyStub)
      return
    }
    provider = mock ? MoyaProvider<ApiRouter>(stubClosure: MoyaProvider.delayedStub(delayMock)) : MoyaProvider<ApiRouter>()
  }
  func doRequest<T: Codable> () -> Observable<T> {
    return Observable.create { observe in
      return self.provider.rx.request(.updateNews).subscribe { event in
        switch event {
          case let .success(response):
            print(T.self)
            if let result = try? JSONDecoder().decode(T.self, from: response.data) {
              observe.onNext(result)
            } else {
              let error = NSError(domain: "com.tung.example", code: 1, userInfo: ["message": "cannot decode"])
              observe.onError(error)
            }
          case .error(let error):
            observe.onError(error)
        }
//
      }
      
    }
  }
}
