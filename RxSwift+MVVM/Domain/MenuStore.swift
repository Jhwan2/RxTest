//
//  MenuStore.swift
//  RxSwift+MVVM
//
//  Created by 주환 on 2023/09/23.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import RxSwift
import UIKit


class MenuStore {
    
    func fetchMenus() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }
        return APIService.fetchAllMenusRX() //Observe<Data>
            .map {
                guard let response = try? JSONDecoder().decode(Response.self, from: $0) else {
                    throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                }
                return response.menus
            }
            // 디코딩 + 변환과정 + Rx로 감싸기..
    }
}
