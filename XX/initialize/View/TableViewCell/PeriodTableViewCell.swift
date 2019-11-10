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
        
        updateButtonStatus(period: .none)
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
            .map { $0.period ?? .none }
            .subscribe(onNext: updateButtonStatus)
            .disposed(by: viewModel.rx.disposeBag)
        
        
        dayButton.rx.action = viewModel.dayOptionAction()
        weekButton.rx.action = viewModel.weekOptionAction()
        monthButton.rx.action = viewModel.monthOptionAction()
        
//        dayButton.rx.tap
//            .map { Category.Period.day }
//            .bind(to: viewModel.periodType)
//            .disposed(by: viewModel.rx.disposeBag)
//        
//        weekButton.rx.tap
//            .map { Category.Period.week }
//            .bind(to: viewModel.periodType)
//            .disposed(by: viewModel.rx.disposeBag)
//        
//        monthButton.rx.tap
//            .map { Category.Period.month }
//            .bind(to: viewModel.periodType)
//            .disposed(by: viewModel.rx.disposeBag)
    }
    
    private func updateButtonStatus(period: Category.Period) {
        let day = (period == .day) ? #colorLiteral(red: 0.1327423155, green: 0.7098431587, blue: 0.6469736695, alpha: 1) : #colorLiteral(red: 0.8077718616, green: 0.8078889251, blue: 0.8116672635, alpha: 1)
        let week = (period == .week) ? #colorLiteral(red: 0.1327423155, green: 0.7098431587, blue: 0.6469736695, alpha: 1) : #colorLiteral(red: 0.8077718616, green: 0.8078889251, blue: 0.8116672635, alpha: 1)
        let month = (period == .month) ? #colorLiteral(red: 0.1327423155, green: 0.7098431587, blue: 0.6469736695, alpha: 1) : #colorLiteral(red: 0.8077718616, green: 0.8078889251, blue: 0.8116672635, alpha: 1)

        dayButton.setTitleColor(day, for: .normal)
        weekButton.setTitleColor(week, for: .normal)
        monthButton .setTitleColor(month, for: .normal)
    }
}
