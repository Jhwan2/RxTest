//
//  CollectionViewModel.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/07.
//

import RxSwift
import UIKit
import RxRelay

class CollectionViewModel {
    
    private var allPronunciationsSubject = BehaviorSubject<ViewPronunciation>(value: ViewPronunciation(title: "", adding: [0]))
    var addData: Observable<ViewPronunciation> {
        return allPronunciationsSubject.asObservable()
    } // data 
    
    // MARK: 입력
    var AddBtnTapped: PublishRelay<Void>?// 디테일 추가 버튼 눌림
    var inputCellTextfield: BehaviorRelay<String>?// 각셀의 숫자 입력 tf
    var inputBtnTapped: PublishSubject<Void>?// 각 셀버튼 입력
    var resultBtnTapped: PublishSubject<Void>?// 연산 버튼 입력
    var titleTF: BehaviorRelay<String>?// 정산 타이틀 입력
    var saveBtnTapped: PublishSubject<Void>?// 저장 버튼 눌림
    
    // MARK: 출력
    var appendData: Observable<Pronunciation>? // 디테일 추가 눌렸을 때 collectionview 최신화 + 데이터 리스트 추가
    // 입력 버튼 눌림 -> 셀의 tf, 버튼 상태수정 및.. 색수정
    // 입력 버튼 눌림 -> 데이터 구조 확인 후 연산버튼 활성화 로직
    // 연산 버튼 눌림 -> 추가, 연산버튼 상태수정, 연산 tf 값 최신화 및 색수정
    // title tf 글자 생성-> 위 조건 만족시 저장 버튼 활성화
    //
    
    init() {
//        let 
    }
    
    
}
