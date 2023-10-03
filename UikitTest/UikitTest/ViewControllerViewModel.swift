//
//  ViewControllerViewModel.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import Foundation

struct DetailViewModel {
    var data: Pronunciation
    
    var resultString: String {
        return "\(data.adding.reduce(0, +))"
    }
    
}
