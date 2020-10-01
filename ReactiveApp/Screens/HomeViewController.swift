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
  
  @IBOutlet weak var outputTextField: UILabel!
  @IBOutlet weak var textInputTextField: UITextField!
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
    let text = textInputTextField.rx.text
    text.bind(to: outputTextField.rx.text).disposed(by: disposeBag)
  }
  
  func setupLayout() {
    
  }
  
  func bindViewModel() {
    
  }
}

