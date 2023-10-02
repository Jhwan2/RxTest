//
//  ViewController.swift
//  UikitTest
//
//  Created by 주환 on 2023/09/28.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private let celliden = "tableViewCell"
    
    var dataList: [Pronunciation] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

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
        let button = defualtButton(title: "추가")
        button.addTarget(self, action: #selector(addPronunciation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        tableViewSet()
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
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(26)
            make.leading.trailing.equalTo(tableView)
            make.height.equalTo(48)
        }
        
        func tableViewSet() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundView = dataList.count == 0 ? emptyView : nil
            tableView.register(VCTableViewCell.self, forCellReuseIdentifier: celliden)
            tableView.rowHeight = 96 + 16
            tableView.separatorStyle = .none
        }
        
    }
    
    @objc func addPronunciation() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celliden, for: indexPath) as! VCTableViewCell
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
//    func tableview
}

