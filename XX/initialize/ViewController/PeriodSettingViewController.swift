//
//  SetPeriodViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class PeriodSettingViewController: UIViewController {
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: PeriodSettingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
        setTableView()
    }
}

extension PeriodSettingViewController {
    private func setTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.alwaysBounceVertical = false
    }
    
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension PeriodSettingViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.categories
            .bind(to: tableView.rx.items(cellIdentifier: PeriodTableViewCell.reuseIdentifier))
            { row, category, cell in
                guard var cell = cell as? PeriodTableViewCell else { return }
                
                let viewModel = self.viewModel(index: row, category: category)
                cell.bind(viewModel: viewModel)
            }
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentNotiSettingAction()
    }
    
    private func viewModel(index: Int, category: Category) -> PeriodSettingCellViewModel {
        if let viewModel = viewModel?.subViewModels[index] {
            return viewModel
        }
        
        let viewModel = PeriodSettingCellViewModel()
        viewModel.category.accept(category)
        self.viewModel?.addSubViewModels(index: index, subViewModel: viewModel)
        
        return viewModel
    }
}
