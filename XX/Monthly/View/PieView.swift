//
//  PieView.swift
//  XX
//
//  Created by 이재은 on 29/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class PieView: UIView {

    override func draw(_ rect: CGRect) {

        let center = CGPoint(x: rect.midX, y: rect.midY)

        let colors = [UIColor(named: "A")!,
                      UIColor(named: "B")!,
                      UIColor(named: "C")!,
                      UIColor(named: "D")!]

        let values: [CGFloat] = [4, 3, 2, 1]
        let total = values.reduce(0, +)

        //x degree = x * π / 180 radian
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0
        var index = 0
        values.forEach { (value) in
            endAngle = (value / total) * (.pi * 2)

            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                        radius: 56,
                        startAngle: startAngle,
                        endAngle: startAngle + endAngle,
                        clockwise: true)

            colors[index].set()
            index += 1
            path.fill()
            startAngle += endAngle
            path.close()
        }

        let semiCircle = UIBezierPath(arcCenter: center,
                                      radius: 37,
                                      startAngle: 0,
                                      endAngle: (360 * .pi) / 180,
                                      clockwise: true)
        UIColor.white.set()
        semiCircle.fill()
    }
}
