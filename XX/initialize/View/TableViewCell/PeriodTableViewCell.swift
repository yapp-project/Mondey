//
//  PeriodTableViewCell.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PeriodTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    
    var viewModel: PeriodSettingCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        viewModel = nil
        dayButton.rx.isSelected.onNext(false)
        weekButton.rx.isSelected.onNext(false)
        monthButton.rx.isSelected.onNext(false)
    }
}

extension PeriodTableViewCell: SignUpSettingCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.category
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.period }
            .subscribe(onNext: updateButtonStatus)
            .disposed(by: viewModel.rx.disposeBag)
        
        dayButton.rx.tapGesture()
            .map { _ in
                Category.Period.day
                
            }
            .subscribe(onNext: viewModel.updatePeriod)
            .disposed(by: viewModel.rx.disposeBag)
        
        weekButton.rx.tapGesture()
            .map { _ in
                Category.Period.week
                
            }
            .subscribe(onNext: viewModel.updatePeriod)
            .disposed(by: viewModel.rx.disposeBag)
        
        monthButton.rx.tapGesture()
            .map { _ in
                Category.Period.month
                
            }
            .subscribe(onNext: viewModel.updatePeriod)
            .disposed(by: viewModel.rx.disposeBag)
    }
    
    private func updateButtonStatus(period: Category.Period?) {
        let day = (period == .day)
        let week = (period == .week)
        let month = (period == .month)
        
        dayButton.rx.isSelected.onNext(day)
        weekButton.rx.isSelected.onNext(week)
        monthButton.rx.isSelected.onNext(month)
    }
}
