//
//  ResultHeaderView.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import UIKit
import SnapKit

protocol ResultHeaderViewDelegate: AnyObject {
    func titleTextFieldDidEndEditing(text: String?)
    func resultButtonTapped()
}

final class ResultHeaderView: UICollectionReusableView {
    
    weak var delegate: ResultHeaderViewDelegate?
    
    private let adddButton: UIButton = {
        let button = defualtButton(title: "연산")
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let resultTextField: UITextField = {
        let tf = lineTextfield()
        tf.isEnabled = false
        return tf
    }()
    
    private let titleTextField: UITextField = {
        return lineTextfield()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        let label: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = .systemFont(ofSize: 14)
           label.text = "결과"
           return label
       }()
       
       let titleLabel: UILabel = {
          let label = UILabel()
          label.textColor = .black
          label.font = .systemFont(ofSize: 14)
          label.text = "정산 타이틀"
          return label
      }()
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .lightGray
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(adddButton)
        adddButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(48)
        }
        
        let stack1 = UIStackView(arrangedSubviews: [label, resultTextField])
        stack1.axis = .vertical
        stack1.spacing = 16
        stack1.alignment = .leading
        
        let stack2 = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
        stack2.axis = .vertical
        stack2.spacing = 16
        stack2.alignment = .leading
        
        let stackView = UIStackView(arrangedSubviews: [stack1, stack2])
        stackView.axis = .vertical
        stackView.spacing = 26
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(adddButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        resultTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(48)
        }
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(48)
        }
        titleTextField.delegate = self
    }
    
    @objc func resultButtonTapped() {
        delegate?.resultButtonTapped()
    }
    
}

extension ResultHeaderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        delegate?.titleTextFieldDidEndEditing(text: newText)
        return true
    }
}
