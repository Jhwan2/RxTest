//
//  Model.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import Foundation

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
