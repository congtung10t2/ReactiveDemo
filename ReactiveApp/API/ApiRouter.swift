//
//  ApiRouter.swift
//  ReactiveApp
//
//  Created by TungImac on 9/29/20.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
  
  case updateNews(parameters: Parameters?)
  
  static let baseURLString = "http://newsapi.org/v2/"
  
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
      case .updateNews(let parameters):
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    }
    return urlRequest
  }
}

extension ApiRouter {
  func request(completion: @escaping (ArticleResponse<ArticleData<Article>>) -> Void ) {
    
    AF.request(self).validate().responseJSON { response in
      switch response.result {
        case .success:
          let result = try? JSONDecoder().decode(ArticleData<Article>.self, from: response.data!)
          completion(.success(result!))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
}

