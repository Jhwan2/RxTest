//
//  Utills.swift
//  UikitTest
//
//  Created by 주환 on 2023/10/02.
//

import UIKit
import SnapKit

func defualtButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12
    button.backgroundColor = .blueCustom
    button.isUserInteractionEnabled = true
    return button
}

func lineTextfield() -> UITextField {
    let field = UITextField(frame: .zero)
    field.layer.cornerRadius = 10
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.isUserInteractionEnabled = true
    return field
}
