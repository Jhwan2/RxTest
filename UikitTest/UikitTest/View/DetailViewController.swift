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
    
    var viewModel: DetailViewModel!
    
    private lazy var saveButton: UIButton = {
        let button = defualtButton(title: "저장")
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    init() {
        viewModel = DetailViewModel(pronunciation: Pronunciation(title: "", adding: [0]))
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
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
    
    private func navigationSet() {
        navigationItem.title = "정산 디테일"
//        let appearance = UINavigationBarAppearance()
//        appearance.shadowColor = .gray
//        appearance.backgroundColor = .white
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func collectionViewSet() {
        collectionView.backgroundColor = .white
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionidentifier)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: identifierCell)
        collectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: resultViewIden)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 85)
        layout.minimumLineSpacing = 32
        collectionView.collectionViewLayout = layout
    }
    
    @objc private func saveButtonTapped() {
        print("버튼눌림 돌아가 !")
        let vc = navigationController?.viewControllers.first as! ViewController
        if let index = viewModel.index {
            vc.dataList[index] = viewModel.data
        } else {
            vc.dataList.append(viewModel.data)
        }
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: CollectionView DataSource
extension DetailViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader, indexPath.section == 0 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionidentifier, for: indexPath) as! SectionHeaderView
            headerView.delegate = self
            return headerView
        } else if kind == UICollectionView.elementKindSectionHeader, indexPath.section == 1 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resultViewIden, for: indexPath) as! ResultHeaderView
            headerView.setSumResult(viewModel.resultString)
            headerView.setTitle(title: viewModel.title)
            headerView.delegate = self
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! DetailCell
        cell.index = indexPath
        cell.textField.text = viewModel.cellTextFieldString(index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? viewModel.data.adding.count : 0
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
        guard let st = text else { return }
        viewModel.data.title = st
    }
    
    func resultButtonTapped() {
        print("연산 하기!")
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? SectionHeaderView {
            headerView.button.isEnabled = false
            headerView.button.backgroundColor = .lightGray
        }
        let sum = viewModel.resultString
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? ResultHeaderView {
            headerView.setSumResult(sum)
        }
        saveButton.backgroundColor = .blueCustom
        saveButton.isEnabled = true
    }
    
}

extension DetailViewController: SectionHeaderViewDelegate {
    func addListButtonTapped() {
        viewModel.data.adding.append(0)
        collectionView.reloadData()
        print("리스트 추가 ! ->")
    }
}

extension DetailViewController: DetailCellDelegate {
    func didTapButton(value: Int, at indexPath: IndexPath) {
        viewModel.data.adding[indexPath.item] = value
        
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? ResultHeaderView {
            headerView.adddButton.backgroundColor = .blueCustom
            headerView.adddButton.isEnabled = true
        }
        
    }
}
