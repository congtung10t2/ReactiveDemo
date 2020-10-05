//
//  Date+Extensions.swift
//  ReactiveApp
//
//  Created by TungImac on 10/5/20.
//

import Foundation
enum DateType: String {
  case simpleFormat = "dd-MM-yyyy"
  case apiResponseFormat = "yyyy-MM-dd"
}

extension Date {
  func toString(type: DateType) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = type.rawValue
    // again convert your date to string
    return formatter.string(from: self)
  }
}


