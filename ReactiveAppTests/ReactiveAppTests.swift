//
//  ReactiveAppTests.swift
//  ReactiveAppTests
//
//  Created by TungImac on 9/26/20.
//

import XCTest
import RxSwift
@testable import ReactiveApp

class ReactiveAppTests: XCTestCase {
  let service = ServiceLayer(mock: true, delayMock: 1.5)
  let disposeBag = DisposeBag()
  func testExample() throws {
    let expect =  self.expectation(description: "expect API finished with 3659 results")
    let homeViewModel = HomeViewModel()
    homeViewModel.request().subscribe(onNext: { value in
      XCTAssertEqual(value.totalResults, 3659)
      expect.fulfill()
    }).disposed(by: disposeBag)
    waitForExpectations(timeout: 2, handler: nil)
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
}
