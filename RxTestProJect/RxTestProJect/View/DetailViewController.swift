//
//  DetailViewController.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/05.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources

final class DetailViewController: UICollectionViewController {
    private let identifierCell = "DetailCell"
    private let sectionidentifier = "SectionHeader"
    private let resultViewIden = "resultViewIden"
    
    private lazy var saveButton: UIButton = {
        let button = defualtButton(title: "저장")
        button.backgroundColor = .lightGray
        button.isEnabled = false
        //        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel: CollectionViewModel = CollectionViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init() {
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        collectionViewSet()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 85)
        layout.minimumLineSpacing = 32
        collectionView.collectionViewLayout = layout
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-42)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
    private func collectionViewSet() {
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        bindViewModel()
        collectionView.backgroundColor = .white
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionidentifier)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: identifierCell)
        collectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: resultViewIden)
        
    }
    
    func bindViewModel() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<CollectionModel>(configureCell: { _, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifierCell, for: indexPath) as! DetailCell
            return cell
        }) { dataSource, collectionView, kind, indexpath in
            switch dataSource[indexpath.section] {
            case .sectionA(_, _):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.sectionidentifier, for: indexpath) as! SectionHeaderView
                return headerView
            case .sectionB(_ , _):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.resultViewIden, for: indexpath) as! ResultHeaderView
                return headerView
            }
        }
        
//        let sections: [SectionModel] = [
//            .sectionA(title: HeaderViewModelA(title: "Section A"), items: [.normal("Item 1"), .normal("Item 2")]),
//            .sectionB(subtitle: HeaderViewModelB(subtitle: "Subtitle for Section B"), items: [.normal("Item 3"), .normal("Item 4")])
//        ]
        
        viewModel.addData
            .map { $0.adding }
            .map { arr in
                [
                    .sectionA(title: HeaderViewModelA(), items: [.adding(arr)]),
                    .sectionB(subtitle: HeaderViewModelB(), items: [])
                ]
            }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
}

//MARK: CollectionView CollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    // 섹션 헤더의 크기를 설정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: collectionView.frame.width, height: 100) : CGSize(width: collectionView.frame.width, height: 300)
    }
    
    // 셀과 헤더 사이의 간격을 조절하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 37, left: 0, bottom: 38, right: 0)
    }
    
}
