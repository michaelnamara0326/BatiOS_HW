//
//  Extensions.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit

extension UIColor {
    static let ubikeGreen = UIColor.customsRGB(r: 184, g: 204, b: 31)
    static let customRgb174 = UIColor.customsRGB(r: 174, g: 174, b: 174)
    static let customRgb235 = UIColor.customsRGB(r: 235, g: 235, b: 235)
    static let customRgb246 = UIColor.customsRGB(r: 246, g: 246, b: 246)
    
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
