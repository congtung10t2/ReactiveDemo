//
//  Article.swift
//  ReactiveApp
//
//  Created by TungImac on 9/29/20.
//

import Foundation
struct Article: Codable {
  let source: ArticleSource
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?
}
struct ArticleSource: Codable {
  let id: String?
  let name: String?
}

struct ArticleData<T: Codable>: Codable {
  let status: String
  let totalResults: Int
  let articles: [T]
}
enum ArticleResponse<T> {
  case success(T)
  case failure(Error)
}
