//
//  GraphTableViewCell.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import Charts

class GraphTableViewCell: UITableViewCell {

    @IBOutlet weak var percentView: PieView!

    let gradeName = ["A", "B", "C", "D"]
    let gradeCount = [4, 3, 2, 1]

    override func awakeFromNib() {
        super.awakeFromNib()
//        drawCharts(dataPoints: gradeName, values: gradeCount.map { Double($0) })
    }

//    func drawCharts(dataPoints: [String], values: [Double]) {
//        // 1. Set ChartDataEntry
//        var dataEntries: [ChartDataEntry] = []
//        for i in 0..<dataPoints.count {
//            let dataEntry = PieChartDataEntry(value: values[i],
//                                              label: dataPoints[i],
//                                              data: dataPoints[i] as AnyObject)
//            dataEntries.append(dataEntry)
//        }
//        // 2. Set ChartDataSet
//        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
//        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
//        // 3. Set ChartData
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        let formatter = DefaultValueFormatter(formatter: format)
//        pieChartData.setValueFormatter(formatter)
//        // 4. Assign it to the chart’s data
////        percentView.isDrawCenterTextEnabled = false
//        percentView.drawEntryLabelsEnabled = false
////        percentView.isDrawEntryLabelsEnabled = false
//        percentView.usePercentValuesEnabled = false
//        
//        percentView.clearsContextBeforeDrawing = true
//        percentView.data = pieChartData
//
//    }

    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(named: "A")!)
        colors.append(UIColor(named: "B")!)
        colors.append(UIColor(named: "C")!)
        colors.append(UIColor(named: "D")!)
        return colors
    }

    func setProperties() {

    }

}
// 44 67 32
