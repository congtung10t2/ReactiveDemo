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

    init(viewModel: HomeViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    }
}
