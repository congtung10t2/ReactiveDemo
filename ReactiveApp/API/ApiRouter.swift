//
//  ApiRouter.swift
//  ReactiveApp
//
//  Created by TungImac on 9/29/20.
//

import Foundation
import Alamofire
import RxSwift

enum ApiRouter: URLRequestConvertible {
  
  case updateNews
  
  static let baseURLString = "http://newsapi.org/v2/"
}

extension ApiRouter {
  
  var method: HTTPMethod {
    switch self {
      case .updateNews:
        return .get
    }
  }
  
  var path: String {
    switch self {
      case .updateNews:
        return "/everything"
    }
  }
  
  // MARK: URLRequestConvertible
  
  func asURLRequest() throws -> URLRequest {
    let url = try ApiRouter.baseURLString.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    switch self {
      case .updateNews:
        urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
    }
    return urlRequest
  }
}

extension ApiRouter {
  func request() -> Observable<ArticleData> {
    return Observable.create { observe in
      let request = AF.request(self).validate().responseJSON { response in
        switch response.result {
          case .success:
            if let result = try? JSONDecoder().decode(ArticleData.self, from: response.data!) {
              observe.onNext(result)
            } else {
              let error = NSError(domain: "com.tung.example", code: 1, userInfo: ["message": "cannot complete the function"])
              observe.onError(error)
            }
            
          case .failure(let error):
            observe.onError(error)
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }
  
}

