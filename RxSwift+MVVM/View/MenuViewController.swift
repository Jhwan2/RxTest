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
import RxController
import RxFlow

class MenuViewController: UIViewController {
    let disposedBag = DisposeBag()
    let viewModel = MenuViewModel()
    let celliden = "MenuItemTableViewCell"
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        setDataSourceUI()
        
        viewModel.totalSelectedCountText
            .observe(on: MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposedBag)
        
        viewModel.totalPriceText
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
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ViewMenu>> { datasource, tableView, IndexPath, item in
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
    
    func setupBindings() {
        // ------------------------------
        //     INPUT
        // ------------------------------

        // 처음 로딩할 때 하고, 당겨서 새로고침 할 때
//        let firstLoad = rx.viewWillAppear
//            .take(1)
//            .map { _ in () }
        let reload = tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .map { _ in () } ?? Observable.just(())
        Observable.merge([firstLoad, reload])
            .bind(to: viewModel.fetchMenus)
            .disposed(by: disposeBag)

        // 처음 보일때 하고 clear 버튼 눌렀을 때
        let viewDidAppear = rx.viewWillAppear.map { _ in () }
        let whenClearTap = clearButton.rx.tap.map { _ in () }
        Observable.merge([viewDidAppear, whenClearTap])
            .bind(to: viewModel.clearSelections)
            .disposed(by: disposeBag)

        // order 버튼 눌렀을 때
        orderButton.rx.tap
            .bind(to: viewModel.makeOrder)
            .disposed(by: disposeBag)

        // ------------------------------
        //     NAVIGATION
        // ------------------------------

        // 페이지 이동
        viewModel.showOrderPage
            .subscribe(onNext: { [weak self] selectedMenus in
                self?.performSegue(withIdentifier: OrderViewController.identifier,
                                   sender: selectedMenus)
            })
            .disposed(by: disposeBag)

        // ------------------------------
        //     OUTPUT
        // ------------------------------

        // 에러 처리
        viewModel.errorMessage
            .map { $0.domain }
            .subscribe(onNext: { [weak self] message in
                self?.showAlert("Order Fail", message)
            })
            .disposed(by: disposeBag)

        // 액티비티 인디케이터
        viewModel.activated
            .map { !$0 }
            .do(onNext: { [weak self] finished in
                if finished {
                    self?.tableView.refreshControl?.endRefreshing()
                }
            })
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)

        // 테이블뷰 아이템들
        viewModel.allMenus
            .bind(to: tableView.rx.items(cellIdentifier: MenuItemTableViewCell.identifier,
                                         cellType: MenuItemTableViewCell.self)) {
                _, item, cell in

                cell.onData.onNext(item)
                cell.onChanged
                    .map { (item, $0) }
                    .bind(to: self.viewModel.increaseMenuCount)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)

        // 선택된 아이템 총개수
        viewModel.totalSelectedCountText
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)

        // 선택된 아이템 총가격
        viewModel.totalPriceText
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
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

