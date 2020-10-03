//
//  HomeViewModel.swift
//  ReactiveApp
//
//  Created by TungImac on 9/29/20.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel: ViewModelType {
  let loading = ActivityIndicator()
  let disposeBag = DisposeBag()
  struct Input {
    let refresh: PublishSubject<Void> = PublishSubject<Void>()
    //Input definition
  }
  
  struct Output {
    let items: BehaviorRelay<[Article]>
    //Output definition
  }
  
  func transform(input: Input) -> Output {
    let items = BehaviorRelay<[Article]>(value: [])
    input.refresh.flatMapLatest { result -> Observable<[Article]> in
      self.request().flatMapLatest { result -> Observable<[Article]> in
        return Observable.of(result.articles)
      }
    }.asObservable().subscribe(onNext: { next in
      items.accept(next)
    }).disposed(by: disposeBag)
    return Output(items: items)
  }
  
  func request() -> Observable<ArticleData> {
    ApiRouter.updateNews.doRequest()
  }
}
