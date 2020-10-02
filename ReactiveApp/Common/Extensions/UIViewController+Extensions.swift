//
//  Extensions+UIViewController.swift
//  ReactiveApp
//
//  Created by TungImac on 10/1/20.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD
extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
              vc.startAnimating()
            } else {
              vc.stopAnimating()
            }
        })
    }
    
}
