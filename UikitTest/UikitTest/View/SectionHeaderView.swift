//
//  SectionHeaderView.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import UIKit
import SnapKit

protocol SectionHeaderViewDelegate: AnyObject {
    func addListButtonTapped()
}

final class SectionHeaderView: UICollectionReusableView {
    
    weak var delegate: SectionHeaderViewDelegate?
    
     private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "정산 디테일"
        return label
    }()
    
    private let button: UIButton = {
        let button = defualtButton(title: "추가")
        button.addTarget(self, action: #selector(addListButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
        }
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalTo(titleLabel.snp.trailing).offset(18)
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        
    }
    
    @objc func addListButtonTapped() {
        delegate?.addListButtonTapped()
    }
    
}


