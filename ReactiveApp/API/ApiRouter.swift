//
//  ApiRouter.swift
//  ReactiveApp
//
//  Created by TungImac on 9/29/20.
//

import Foundation
import RxSwift
import Moya

enum ApiRouter: TargetType {
  var baseURL: URL { return URL(string: "https://newsapi.org/v2/")! }
  
  var sampleData: Data {
    
    guard let url = Bundle.main.url(forResource: "news", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
      return Data()
    }
    return data
    
  }
  var task: Task {
    //request .requestPlain
    return .requestParameters(parameters: self.param!, encoding: URLEncoding.queryString)
    
  }
  
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
  
  case updateNews
}

extension ApiRouter {
  
  var method: Moya.Method {
    switch self {
      case .updateNews:
        return .get
    }
  }
  
  var path: String {
    switch self {
      case .updateNews:
        return "everything"
    }
  }
}
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}
