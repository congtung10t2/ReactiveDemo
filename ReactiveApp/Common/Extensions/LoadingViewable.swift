//
//  LoadingViewable.swift
//  ReactiveApp
//
//  Created by TungImac on 10/1/20.
//

import Foundation
import UIKit
import MBProgressHUD
protocol LoadingViewable {
  func startAnimating()
  func stopAnimating()
}
extension LoadingViewable where Self : UIViewController {
  func startAnimating() {
    MBProgressHUD.showAdded(to: self.view, animated: true)
  }
  func stopAnimating() {
    MBProgressHUD.hide(for: self.view, animated: true)
  }
}
