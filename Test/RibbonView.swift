//
//  RibbonView.swift
//  Locator
//
//  Created by Vincent O'Sullivan on 28/12/2016.
//  Copyright © 2016 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class RibbonView: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxY * 2.0 / 8.0, y: rect.maxY / 2.0))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX - rect.maxY * 2.0 / 8.0, y: rect.maxY / 2.0))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.closePath()

        context.setFillColor(UIColor.red.cgColor) //  or(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        context.fillPath()
        super.draw(rect)
    }
}
