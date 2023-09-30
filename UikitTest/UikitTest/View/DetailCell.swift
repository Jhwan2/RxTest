//
//  DetailCell.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/30.
//

import UIKit
import SnapKit

class DetailCell: UICollectionViewCell {
    
    var num: Int = 0
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "더할 것 1"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("입력", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        button.tintColor = .white
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
