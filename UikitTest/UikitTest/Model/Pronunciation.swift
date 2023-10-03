//
//  Pronunciation.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/28.
//

import Foundation

struct Pronunciation {
    var title: String
    var adding: [Int]
    
    func sumOfAdding() -> Int {
        return adding.reduce(0, +)
    }
}
