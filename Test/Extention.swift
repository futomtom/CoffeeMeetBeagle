//
//  Extention.swift
//  Test
//
//  Created by alexfu on 1/20/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
}


extension UIImageView {

    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
                  red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0)
        )
    }
}

extension UIView {

    func bindFrameToSuperviewBounds() {
        translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }

    func indentFrameToSuperviewBounds() {
        translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[subview]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
}
