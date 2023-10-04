//
//  DetailCell.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/30.
//

import UIKit
import SnapKit

protocol DetailCellDelegate: AnyObject {
    func didTapButton(value: Int, at indexPath: IndexPath)
}

final class DetailCell: UICollectionViewCell {
    
    var index: IndexPath!
    
    weak var delegate: DetailCellDelegate?
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "더할 것"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    var textField: UITextField = {
        return lineTextfield()
    }()
    
    private lazy var button: UIButton = {
        let button = defualtButton(title: "입력")
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.addTarget(self, action: #selector(inputBtnTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
        textField.delegate = self
    }
    
    func updateUI() {
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.setTitle("완료", for: .normal)
        textField.layer.borderColor = UIColor.blueCustom.cgColor
    }
    
    @objc private func inputBtnTapped() {
        guard let number = textField.text else { return }
        let num = Int(number) ?? 1
        updateUI()
        delegate?.didTapButton(value: num, at: index)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }

        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

        // 입력값이 한 자리 이상인 경우에만 버튼 활성화
        if newText.count > 0 {
            button.backgroundColor = .blueCustom
            button.isEnabled = true
        } else {
            button.backgroundColor = .lightGray
            button.isEnabled = false
        }

        // 입력값이 숫자인지 확인
        let isNumeric = newText.allSatisfy { $0.isNumber }

        return isNumeric
    }
}

