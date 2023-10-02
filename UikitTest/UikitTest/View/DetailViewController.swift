//
//  DetailViewController.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/30.
//

import UIKit
import SnapKit

final class DetailViewController: UICollectionViewController {
    private let identifierCell = "DetailCell"
    private let sectionidentifier = "SectionHeader"
    private let resultViewIden = "resultViewIden"
    
    var pronunciaion: Pronunciation {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let saveButton: UIButton = {
        let button = defualtButton(title: "저장")
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init() {
        pronunciaion = Pronunciation(title: "dumy", adding: [])
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        navigationSet()
        collectionViewSet()
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-42)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
    func navigationSet() {
        navigationItem.title = "정산 디테일"
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func collectionViewSet() {
        collectionView.backgroundColor = .white
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionidentifier)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: identifierCell)
        collectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: resultViewIden)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 390, height: 81)
        layout.minimumLineSpacing = 32
        collectionView.collectionViewLayout = layout
    }
    
    @objc func saveButtonTapped() {
        print("버튼눌림 돌아가 !")
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: CollectionView Delegate
extension DetailViewController {
    
}

//MARK: CollectionView DataSource
extension DetailViewController {
    // 섹션 헤더의 뷰를 반환하는 메서드
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader, indexPath.section == 0 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionidentifier, for: indexPath) as! SectionHeaderView
            headerView.delegate = self
            return headerView
        } else if kind == UICollectionView.elementKindSectionHeader, indexPath.section == 1 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resultViewIden, for: indexPath) as! ResultHeaderView
            headerView.delegate = self
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as? DetailCell ?? UICollectionViewCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return section == 0 ? pronunciaion.adding.count : 1
        return section == 0 ? 1 : 0
    }
}

//MARK: CollectionView CollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    // 섹션 헤더의 크기를 설정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: collectionView.frame.width, height: 50) : CGSize(width: collectionView.frame.width, height: 300)
    }
    
    // 셀과 헤더 사이의 간격을 조절하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 37, left: 0, bottom: 38, right: 0)
    }

}

extension DetailViewController: ResultHeaderViewDelegate {
    func titleTextFieldDidEndEditing(text: String?) {
        print(text ?? "@@")
    }
    
    func resultButtonTapped() {
        print("연산 하기!")
    }
    
}

extension DetailViewController: SectionHeaderViewDelegate {
    func addListButtonTapped() {
        print("리스트 추가 !")
    }
    
}
