//
//  ViewController.swift
//  ReactiveApp
//
//  Created by TungImac on 9/26/20.
//

import UIKit
import Alamofire

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      let params: Parameters = ["q": "bitcoin", "from": "2020-08-29", "sortBy": "publishedAt", "apiKey": "e9f9b296fc8f4a4388bd5b88b4556473"]
      ApiRouter.updateNews(parameters: params).request { response in
        switch response {
          case .success(let data):
            print(data)
          case .failure(let error):
            print(error)
        }
      }
      
    }
}

