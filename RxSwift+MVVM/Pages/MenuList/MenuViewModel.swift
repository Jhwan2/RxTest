//
//  MenuViewModel.swift
//  RxSwift+MVVM
//
//  Created by 주환 on 2023/09/17.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MenuViewModel {
    var menusOb = BehaviorSubject<[Menu]>(value: [])
    
    lazy var totalPrice = menusOb.map { $0.map { $0.num * $0.price }.reduce(0,+)}
    lazy var itemsCount = menusOb.map { $0.map { $0.num}.reduce(0, +) }
    
    init() {
        let menus = [Menu(id: 0, name: "default", price: 100, num: 0),
                     Menu(id: 1, name: "default", price: 100, num: 5),
                     Menu(id: 2, name: "default", price: 100, num: 3),
                     Menu(id: 3, name: "default", price: 100, num: 0)
        ]
        menusOb.onNext(menus)
    }
    
    func itemClear() {
        menusOb.map{ $0.map { Menu(id: $0.id, name: $0.name, price: $0.price, num: 0)} }
            .take(1)
            .subscribe(onNext: { self.menusOb.onNext($0)})
    }
    func changeNum(item: Menu, increase: Int) {
        menusOb.map { $0.map { if $0.id == item.id { return Menu(id: $0.id, name: $0.name, price: $0.price, num: max($0.num + increase, 0)) } else { return Menu(id: $0.id, name: $0.name, price: $0.price, num: $0.num) }
        } }
            .take(1)
            .subscribe(onNext: { self.menusOb.onNext($0)})
    }
}
//2:57:27

