//
//  HomeViewController.swift
//  ReactiveApp
//
//  Created by TungImac on 9/27/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
  fileprivate let viewModel: HomeViewModel
  fileprivate let disposeBag = DisposeBag()
  @IBOutlet private weak var tableView: UITableView!
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = HomeViewModel()
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupLayout()
    bindViewModel()
  }
}

// MARK: Setup
private extension HomeViewController {
  
  func setupViews() {
    
  }
  
  func setupLayout() {
    
  }
  
  func bindViewModel() {
    let input = HomeViewModel.Input()
    input.refresh.onNext(())
    let output = viewModel.transform(input: input)
    output.items.bind(to: tableView.rx.items(cellIdentifier: ArticleViewModelViewCell.identifier, cellType: ArticleViewModelViewCell.self)) { index, model, cell in
      cell.bindViewModel(with: ArticleViewModel(with: model))
    }
  }
}

