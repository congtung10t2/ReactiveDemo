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
  let disposeBag = DisposeBag()
  @IBOutlet private weak var title: UILabel!
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
  }
  
  func bindViewModel(with viewModel: ArticleViewModel) {
    self.viewModel = viewModel
    makeUI()
  }
  
  func makeUI() {
    viewModel.title.asDriver().drive(title.rx.text).disposed(by: disposeBag)
  }
}
