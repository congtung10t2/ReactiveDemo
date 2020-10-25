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
  let isLoading = BehaviorRelay(value: false)
  let viewWillAppear = PublishSubject<Void>()
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.viewWillAppear.onNext(())
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
    let output = viewModel.transform(input: input)
    output.error.asObserver().subscribe { [weak self] error in
      self?.alert(message: error.element?.localizedDescription ?? "")
    }.disposed(by: disposeBag)
    viewWillAppear.asObserver().bind(to: input.viewWillAppear).disposed(by: disposeBag)
    viewModel.loading.asObservable().bind(to: rx.isAnimating).disposed(by: disposeBag)
    output.items.bind(to: tableView.rx.items(cellIdentifier: ArticleViewModelViewCell.identifier, cellType: ArticleViewModelViewCell.self)) { index, model, cell in
      cell.bindViewModel(with: ArticleViewModel(with: model))
    }.disposed(by: disposeBag)
    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        let cell = self?.tableView.cellForRow(at: indexPath) as? ArticleViewModelViewCell
        guard let title = cell?.viewModel.article.title else { return }
        print(title)
      }).disposed(by: disposeBag)
  }
}

