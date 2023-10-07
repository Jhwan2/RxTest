//
//  ViewController.swift
//  RxTestProJect
//
//  Created by 주환 on 2023/10/04.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

let identifierTableCell = "tableCell"
class ViewController: UIViewController {
    
    let viewModel: TableViewModelType
    var disposedBag = DisposeBag()
    
    private let labelOne: UILabel = {
       let label = UILabel()
        label.text = "정산목록"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.backgroundColor = .white
        tableview.register(VCTableViewCell.self, forCellReuseIdentifier: identifierTableCell)
        return tableview
    }()
    
    private let emptyView: UIView = {
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
    
    private lazy var addButton: UIButton = {
        let button = defualtButton(title: "추가")
        return button
    }()
    
    init(viewModel: TableViewModel = TableViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = TableViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDataSourceUI()
        // Do any additional setup after loading the view.
    }
    
    func setupBindings() {
        viewModel.isEmptyArr
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] bool in
                self?.tableView.backgroundView = bool ? self?.emptyView : nil
            }
            .disposed(by: disposedBag)
        
        addButton.rx.tap
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: disposedBag)
        
        viewModel.navigateToNextScreen
            .subscribe(onNext: { [weak self] in
                self?.navigateToNextScreen()
            }).disposed(by: disposedBag)
    }
    
    func setDataSourceUI() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ViewPronunciation>>(configureCell: { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierTableCell) as! VCTableViewCell
//            cell.data = item
            return cell
        })


        viewModel.allPronunciations
            .map { [SectionModel(model: "Section", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposedBag)

        setupBindings()
    }


    
    private func navigateToNextScreen() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: View
extension ViewController {
    private func configureUI() {
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
    }
}
