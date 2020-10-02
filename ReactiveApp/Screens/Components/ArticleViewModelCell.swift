//
//  ArticleViewModelCell.swift
//  ReactiveApp
//
//  Created by TungImac on 10/1/20.
//

import Foundation
import RxSwift
import UIKit

class ArticleViewModel: DefaultTableViewCellViewModel {
  let article: Article
  init(with article: Article) {
    self.article = article
    super.init()
    title.accept(article.title)
  }
}
class ArticleViewModelViewCell: UITableViewCell {
  static let identifier = "ArticleViewModelViewCell"
  var viewModel: ArticleViewModel!
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      makeUI()
  }
  
  func bindViewModel(with viewModel: ArticleViewModel) {
    self.viewModel = viewModel
  }
  
  func makeUI() {
    
  }
}
