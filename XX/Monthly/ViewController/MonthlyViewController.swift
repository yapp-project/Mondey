//
//  MonthlyViewController.swift
//  XX
//
//  Created by 이재은 on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MonthlyViewController: BaseViewController {
    
    @IBOutlet private weak var monthlyTableView: UITableView!
    @IBOutlet weak var naviItem: UINavigationItem!
    
    //    static let reuseIdentifier = "GradeCollectionViewCell"
    let MAIN_CELL_WIDTH = UIScreen.main.bounds.width * 0.405
    
    var viewModel: MonthlyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        bindViewModel()
        //        bindCollectionView()
        setNaviBar()
    }
    
    private func setNaviBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SpoqaHanSans-Regular", size: 15)!]
        naviItem.titleView?.tintColor = UIColor(named: "51")
        UINavigationBar.appearance().titleTextAttributes = attributes
        naviItem.title = "월별 등급 평가"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func pushMonthlyDetail(month: Int, grade: String) {
        let storyboard = UIStoryboard(name: "Monthly",
                                      bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "MonthlyDetailViewController") as? MonthlyDetailViewController
            else { return }
        viewController.month = month
        viewController.grade = grade
        
        self.navigationController?.pushViewController(viewController,
                                                      animated: true)
    }
    
    private func pushPickYearView() {
        let storyboard = UIStoryboard(name: "Monthly", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PickYearViewController")
        viewController.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(viewController, animated: false)
    }
    
}

extension MonthlyViewController: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        //        yearButton.rx.action = viewModel.presentingSelectYear()
        
    }
    
    private func bindCollectionView() {
        guard let viewModel = viewModel else { return }
        
        let dummy = ["A", "B", "C"]
        let sections = [SectionModel<String, String>(model: "1", items: dummy)]
        
        //        gradeCollectionView.rx.itemSelected.bind { (indexPath) in
        //            //            viewModel.req
        //            }.disposed(by: rx.disposeBag)
        //
        //        gradeCollectionView
        //            .rx.setDelegate(self)
        //            .disposed(by: rx.disposeBag)
        
        //        Observable.just(sections)
        //        .bind(to: gradeCollectionView.rx.items(dataSource: mainDataSource))
        //            .disposed(by: rx.disposeBag)
    }
    
    typealias MainSectionModel = SectionModel<String, String>
    typealias MainCollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<MainSectionModel>
    
    //    private var mainDataSource: MainCollectionViewDataSource {
    //        let configureCell: (RxCollectionViewSectionedReloadDataSource<MainSectionModel>, UICollectionView, IndexPath, String) -> UICollectionViewCell = { (dataSource, collectionView, indexPath, element) in
    //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? GradeCollectionViewCell else { return UICollectionViewCell() }
    
    //            return cell
    //        }
    //    }
    
}

//extension MonthlyViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: MAIN_CELL_WIDTH,
//                      height: MAIN_CELL_WIDTH)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let padding = (UIScreen.main.bounds.width - (MAIN_CELL_WIDTH * 2)) / 4 + 10
//        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
//    }
//}

extension MonthlyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let gradeCell = tableView
                .dequeueReusableCell(withIdentifier: "GradeTableViewCell",
                                     for: indexPath) as? GradeTableViewCell
                else { return UITableViewCell() }
            gradeCell.delegate = self
            
            return gradeCell
            
        case 1:
            guard let graphCell = tableView
                .dequeueReusableCell(withIdentifier: "GraphTableViewCell",
                                     for: indexPath) as? GraphTableViewCell
                else { return UITableViewCell() }
            
            graphCell.setProperties()
            
            return graphCell
            
        default:
            return UITableViewCell()
            
        }
    }
}

extension MonthlyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 540
        } else {
            return 230
        }
    }
}

// MARK: - CuratedCellDelegate

extension MonthlyViewController: GradeCellDelegate {
    
    func moveMonthlyDetailView(month: Int, grade: String) {
        pushMonthlyDetail(month: month, grade: grade)
    }
    
    func movePickYearView() {
        pushPickYearView()
    }
    
}
