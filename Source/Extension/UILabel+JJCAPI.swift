//
//  UILabel+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 设置 UILabel 属性
extension UILabel {
    
    /// UILabel - 设置属性：text、textColor、font、fontFamily、fontSize、weight、aligment
    /// 注意：font、（fontFamily、fontSize）、（fontSize、weight）三者设置一种即可，其它的设置为 nil
    public func jjc_params(text: String,
                           textColor: UIColor? = nil,
                           font: UIFont? = nil,
                           fontFamily: String? = nil,
                           fontSize: CGFloat? = nil,
                           weight: UIFont.Weight? = nil,
                           aligment: NSTextAlignment? = nil) {
        self.text = text
        if let newTextColor = textColor {
            self.textColor = newTextColor
        }
        
        var tempFont: UIFont?
        if let newFont = font {
            tempFont = newFont
        }
        if let newFontSize = fontSize {
            if let newFontFamily = fontFamily {
                tempFont = UIFont(name: newFontFamily, size: newFontSize)
            } else {
                tempFont = .systemFont(ofSize: newFontSize, weight: weight ?? .regular)
            }
        }
        self.font = tempFont
        
        if let newAligment = aligment {
            self.textAlignment = newAligment
        }
    }
}
