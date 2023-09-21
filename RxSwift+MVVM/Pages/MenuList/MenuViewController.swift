//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MenuViewController: UIViewController {
    let disposedBag = DisposeBag()
    let viewModel = MenuViewModel()
    let celliden = "MenuItemTableViewCell"
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSourceUI()
//        viewModel.menusOb
//            .bind(to: tableView.rx.items(cellIdentifier: celliden, cellType: MenuItemTableViewCell.self)) { (index, item, cell) in
//                cell.title.text = item.name
//                cell.price.text = "\(item.price)"
//                cell.count.text = "\(item.num)"
//
//                cell.onChange = { [weak self] int in
//                    self?.viewModel.changeNum(item: item, increase: int)
//                }
//            }
//            .disposed(by: disposedBag)
            
        
        viewModel.itemsCount
            .map { "\($0)" }
            .observe(on: MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposedBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .observe(on: MainScheduler.instance)
            .bind(to: totalPrice.rx.text )
            .disposed(by: disposedBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
    
    func setDataSourceUI() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Menu>> { datasource, tableView, IndexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.celliden, for: IndexPath) as! MenuItemTableViewCell
            cell.title.text = item.name
            cell.price.text = "\(item.price)"
            cell.count.text = "\(item.num)"
            
            cell.onChange = { [weak self] int in
                self?.viewModel.changeNum(item: item, increase: int)
            }

            return cell
        }
        viewModel.menusOb
            .map { [SectionModel(model: "Section", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposedBag)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.itemClear()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
        
        viewModel.menusOb.onNext([Menu(id: 0, name: "changed", price: 100, num: 2)])
    }
}

//extension MenuViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
//
//        cell.title.text = "MENU \(indexPath.row)"
//        cell.price.text = "\(indexPath.row * 100)"
//        cell.count.text = "0"
//
//        return cell
//    }
//}
