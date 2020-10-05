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
          DispatchQueue.main.async {
            if !active {
              vc.startAnimating()
            } else {
              vc.stopAnimating()
            }
          }
            
        })
    }
    
}
extension UIViewController {
  var topViewController: UIViewController? {
    if let  topController = UIApplication.shared.windows.first?.rootViewController  {
        while let presentedViewController = topController.presentedViewController {
            return presentedViewController
        }
    }
    return nil
  }
  
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
}
