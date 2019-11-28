//
//  MonthlyViewController.swift
//  XX
//
//  Created by 이재은 on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MonthlyViewController: BaseViewController {

    
    


//    static let reuseIdentifier = "GradeCollectionViewCell"
    let MAIN_CELL_WIDTH = UIScreen.main.bounds.width * 0.405

    var viewModel: MonthlyViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        //        bindCollectionView()
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

extension MonthlyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MAIN_CELL_WIDTH,
                      height: MAIN_CELL_WIDTH)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = (UIScreen.main.bounds.width - (MAIN_CELL_WIDTH * 2)) / 4 + 10
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}
