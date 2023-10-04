//
//  ViewControllerViewModel.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import Foundation

struct DetailViewModel {
    var data: Pronunciation
    
    var index: IndexPath.Element?
    
    var resultString: String {
        let sum = data.adding.reduce(0, +)
        return sum == 0 ? "" : "\(data.adding.reduce(0, +))"
    }
    
    var title: String {
        return data.title
    }

    init(pronunciation: Pronunciation) {
        self.data = pronunciation
    }
    
    func cellTextFieldString(index: IndexPath.Index) -> String {
        return resultString == "" ? "" : "\(data.adding[index])"
    }

    mutating func updateTitle(_ newTitle: String) {
        self.data.title = newTitle
    }
}
