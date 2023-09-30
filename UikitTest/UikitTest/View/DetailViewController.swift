//
//  DetailViewController.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/30.
//

import UIKit
import SnapKit

class DetailViewController: UICollectionViewController {
    private let iendtifierCell = "DetailCell"
    
    var pronunciaion: Pronunciation {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
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
    
    func collectionViewSet() {
        collectionView.backgroundColor = .white
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: iendtifierCell)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 390, height: 81)
        layout.minimumLineSpacing = 32
        collectionView.collectionViewLayout = layout
    }
    
    func configureUI() {
        collectionViewSet()
        navigationItem.title = "정산 디테일"
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-42)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }

}

//MARK: CollectionView Delegate
extension DetailViewController {
    
}

//MARK: CollectionView DataSource
extension DetailViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: iendtifierCell, for: indexPath) as? DetailCell ?? UICollectionViewCell()
        
//        cell.backgroundColor = .green
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
//        return pronunciaion.adding.count
    }
}

//MARK: CollectionView CollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
}
