//
//  ViewPronunciation.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/05.
//

import Foundation

struct ViewPronunciation {
    var title: String
    var adding: [Int]
    var total: Int

    init(_ item: Pronunciation) {
        title = item.title
        adding = item.adding
        total = 0
    }

    init(title: String, adding: [Int]) {
        self.title = title
        self.adding = adding
        self.total = adding.reduce(0, +)
    }

    func addingUpdated(_ adding: [Int]) -> ViewPronunciation {
        return ViewPronunciation(title: title, adding: adding)
    }

    func asMenuItem() -> ViewPronunciation {
        return ViewPronunciation(title: title, adding: adding)
    }
}
