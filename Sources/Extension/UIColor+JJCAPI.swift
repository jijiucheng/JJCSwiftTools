//
//  UIColor+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 便利构造 UIColor 方法
extension UIColor {
    
    /// UIColor - 获取十六进制字符串 UIColor -> Hex String
    public var jjc_hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        if alpha == 1.0 {
            return String(format: "#%02lX%02lX%02lX",
                          Int(red * multiplier),
                          Int(green * multiplier),
                          Int(blue * multiplier))
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX",
                          Int(red * multiplier),
                          Int(green * multiplier),
                          Int(blue * multiplier),
                          Int(alpha * multiplier))
        }
    }
    
    /// UIColor - 初始化 RGBA 颜色，无需输入 255
    public convenience init(color255 red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat? = 1.0) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha ?? 1.0)
    }
    
    /// UIColor - 初始化 十六进制颜色
    public convenience init(hexString: String, alpha: CGFloat? = 1.0) {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
        var color: UInt64 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanHexInt64(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: alpha ?? 1.0)
    }
}

// MARK:- UIColor 转换方法
extension UIColor {
    
    /// UIColor - 颜色转图片
    public func jjc_toImage() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
