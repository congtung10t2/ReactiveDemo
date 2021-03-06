//
//  ApiParams.swift
//  ReactiveApp
//
//  Created by TungImac on 10/2/20.
//

import Foundation

extension ApiRouter {
  var param: [String: String]? {
    switch self {
      case .updateNews:
        return ["q": "bitcoin", "from": Date().toString(type: .apiResponseFormat), "sortBy": "publishedAt", "apiKey": "e9f9b296fc8f4a4388bd5b88b4556473"]
    }
  }
}
