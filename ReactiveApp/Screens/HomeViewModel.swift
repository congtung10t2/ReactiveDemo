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
  let disposeBag = DisposeBag()
  let loading = ActivityIndicator()
  struct Input {
    let refresh: PublishSubject<Void> = PublishSubject<Void>()
    let viewWillAppear = PublishSubject<Void>()
    //Input definition
  }
  
  struct Output {
    let items: BehaviorRelay<[Article]>
    let error: PublishSubject<Error>
    //Output definition
  }
  
  func transform(input: Input) -> Output {
    let items = BehaviorRelay<[Article]>(value: [])
    let publishError = PublishSubject<Error>()
    input.viewWillAppear.bind(to: input.refresh).disposed(by: disposeBag)
    input.refresh.flatMapLatest { result -> Observable<[Article]> in
      self.request().flatMapLatest { result -> Observable<[Article]> in
        return Observable.of(result.articles)
      }.catchError { error -> Observable<[Article]> in
        publishError.onNext(error)
        return Observable.of([])
      }
    }.asObservable().subscribe(onNext: { next in
        items.accept(next)
    }).disposed(by: disposeBag)
    return Output(items: items, error: publishError)
  }
  
  func request() -> Observable<ArticleData> {
    ApiRouter.updateNews.doRequest().trackActivity(loading)
  }
}
