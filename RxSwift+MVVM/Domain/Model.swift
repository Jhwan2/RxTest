//
//  Model.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import Foundation
import RxDataSources

struct MenuItem: Decodable {
    var name: String
    var price: Int
}

struct Menu {
    var id: Int
    var name: String
    var price: Int
    var num: Int
}

//extension Menu: SectionModelType {
//    init(original: Menu, items: [Menu]) {
//        self = original
//    }
//    
//    var items: [Menu] {
//        [Menu(id: 0, name: "default", price: 100, num: 0),
//                     Menu(id: 1, name: "default", price: 100, num: 5),
//                     Menu(id: 2, name: "default", price: 100, num: 3),
//                     Menu(id: 3, name: "default", price: 100, num: 0)
//        ]
//    }
//    
//    typealias Item = Menu
//    
//}
