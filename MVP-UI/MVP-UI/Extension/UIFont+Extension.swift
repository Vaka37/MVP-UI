// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение доступа к шрифтам
extension UIFont {
    class func verdana(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "Verdana", size: size) {
            return customFont
        }
        return UIFont.systemFont(ofSize: size)
    }

    class func verdanaBold(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "Verdana-Bold", size: size) {
            return customFont
        }
        return UIFont.systemFont(ofSize: size)
    }
}
