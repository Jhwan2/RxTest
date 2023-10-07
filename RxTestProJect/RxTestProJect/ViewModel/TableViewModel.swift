//
//  TableViewModel.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/05.
//

import UIKit
import RxSwift

protocol TableViewModelType {
    // input
    var makePronunciation: AnyObserver<Void> { get }
    var nextButtonTapped: PublishSubject<Void> { get }

    // output
    var navigateToNextScreen: Observable<Void> { get }
    var allPronunciations: Observable<[ViewPronunciation]> { get }
    var isEmptyArr: Observable<Bool> { get }
}

class TableViewModel: TableViewModelType {
    private let disposeBag = DisposeBag()
    
    var nextButtonTapped = PublishSubject<Void>()
    var navigateToNextScreen: Observable<Void>
    
    private var makePronunciationSubject = PublishSubject<Void>()
    var makePronunciation: AnyObserver<Void> {
        return makePronunciationSubject.asObserver()
    }

    private var allPronunciationsSubject = BehaviorSubject<[ViewPronunciation]>(value: [])
    var allPronunciations: Observable<[ViewPronunciation]> {
        return allPronunciationsSubject.asObservable()
    }

    var isEmptyArr: Observable<Bool> {
        return allPronunciations.map { $0.isEmpty }
    }

    init() {
        navigateToNextScreen = nextButtonTapped.asObservable()
        makePronunciationSubject
            .withLatestFrom(allPronunciations)
            .map { list -> [ViewPronunciation] in
                // Perform your logic to add a new item to the list
                // For now, let's just add a dummy item
                return list + [ViewPronunciation(title: "", adding: [0])]
            }
            .bind(to: allPronunciationsSubject)
            .disposed(by: disposeBag)
    }
}

