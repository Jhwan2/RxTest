//
//  VCTableViewCell.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import UIKit
import SnapKit

protocol VCTableViewCellDelegate: AnyObject {
    func delButtonTapped(index: IndexPath.Element)
}

final class VCTableViewCell: UITableViewCell {
    
    weak var delegate: VCTableViewCellDelegate?
    
    var index: IndexPath.Element?
    
    var data: Pronunciation? {
        didSet {
            dataInput()
        }
    }
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "22"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var resultStack: UIView = {
        let label1 = UILabel()
        label1.text = "결과"
        label1.font = .boldSystemFont(ofSize: 14)
        let stack = UIStackView(arrangedSubviews: [label1, resultLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = -27
        stack.layer.cornerRadius = 12
        stack.backgroundColor = UIColor(red: 0.133, green: 0.58, blue: 1, alpha: 0.1)
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "정산 A"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    var delButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        guard let pro = p
        delButton.addTarget(self, action: #selector(delButtonTapped), for: .touchUpInside)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
    
    func configureUI() {
        addSubview(resultStack)
        resultStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(80)
            make.leading.equalToSuperview()
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(resultStack.snp.trailing).offset(14)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(delButton)
        delButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func dataInput() {
        guard let data = data else { return }
        resultLabel.text = "\(data.sumOfAdding())"
        titleLabel.text = data.title
    }
    
    @objc func delButtonTapped() {
        print("삭제버튼눌림")
        guard let index = index else { return }
        delegate?.delButtonTapped(index: index)
    }

}
