//
//  CollectionViewModel.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/05.
//

import RxSwift
import RxDataSources
import RxRelay

// 첫 번째 섹션의 헤더 뷰 모델
struct HeaderViewModelA {
    var listAppendBtn: PublishRelay<Void>
    
    init() {
        listAppendBtn = PublishRelay<Void>()
    }
}

// 두 번째 섹션의 헤더 뷰 모델
struct HeaderViewModelB {
    var resultString: BehaviorSubject<String>
    
    init() {
        resultString = BehaviorSubject<String>(value: "")
    }
}

enum CollectionModel {
    case sectionA(title: HeaderViewModelA, items: [SectionItem])
    case sectionB(subtitle: HeaderViewModelB, items: [SectionItem])

    enum SectionItem {
        case adding([Int])
    }
}

extension CollectionModel: SectionModelType {
    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case let .sectionA(_, items), let .sectionB(_, items):
            return items.map { $0 }
        }
    }

    init(original: CollectionModel, items: [Item]) {
        switch original {
        case let .sectionA(title, _):
            self = .sectionA(title: title, items: items)
        case let .sectionB(subtitle, _):
            self = .sectionB(subtitle: subtitle, items: items)
        }
    }
}
