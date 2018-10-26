//
//  ViewModel.swift
//  MVVM_Rx
//
//  Created by Jinu Kim on 25/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    let searchText = Variable("")
    
    lazy var data: Driver<[Repository]> = {
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(ViewController.repositoriesBy)
            .asDriver(onErrorJustReturn: [])
//        return Observable.of([Repository]()).asDriver(onErrorJustReturn: [])
    }()
}
