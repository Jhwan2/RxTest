//
//  DetailCell.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/30.
//

import UIKit
import SnapKit

final class DetailCell: UICollectionViewCell {
    
    var num: Int = 0
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "더할 것"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var textField: UITextField = {
        return lineTextfield()
    }()
    
    private lazy var button: UIButton = {
        let button = defualtButton(title: "입력")
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20.24)
        }
        
        let stack = UIStackView(arrangedSubviews: [textField, button])
        stack.axis = .horizontal
        stack.spacing = 11.65
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(59.31)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
