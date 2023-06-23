//
//  Extensions.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit

extension UIColor {
    static func customsRGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

extension UIView {
    func deactiveAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubviews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIFont {
    enum FontWeight: String {
        case regular = "PingFangTC-Regular"
        case medium = "PingFangTC-Medium"
        case semibold = "PingFangTC-Semibold"
    }
    
    static func PingFangTC(fontSize size: CGFloat, weight fontName: FontWeight) -> UIFont {
        return UIFont(name: fontName.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
