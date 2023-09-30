//
//  ViewController.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let labelOne: UILabel = {
       let label = UILabel()
        label.text = "정산목록"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let tableView: UITableView = {
        let collection = UITableView(frame: .zero)
        collection.backgroundColor = .white
        return collection
    }()
    
    let emptyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        view.layer.cornerRadius = 12
        let label = UILabel()
        label.text = "텅 !!!"
        label.font = .boldSystemFont(ofSize: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.13, green: 0.58, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(addPronunciation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(labelOne)
        labelOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(87)
            make.leading.equalToSuperview().offset(16)
        }
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(188)
            make.width.equalTo(358)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelOne.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(358)
            make.height.equalTo(188)
        }
        tableView.backgroundView = emptyView
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(26)
            make.leading.trailing.equalTo(tableView)
            make.height.equalTo(48)
        }
        
    }
    
    @objc func addPronunciation() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

