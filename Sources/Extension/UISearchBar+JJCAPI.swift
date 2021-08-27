//
//  UISearchBar+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 设置系统属性
extension UISearchBar {
    
    /// UISearchBar - 去除搜索框黑线
    public func jjc_removeBlackLine() {
        searchBarStyle = .minimal
    }
    
    /// UISearchBar - 获取当前 TextField
    public func jjc_textField() -> UITextField? {
        if self.value(forKey: "searchField") is UITextField {
            let textField: UITextField = self.value(forKey: "searchField") as! UITextField
            return textField
        }
        return nil
    }
    
    /// UISearchBar - 设置当前 TextField 的背景色：bgColor
    public func jjc_textField(bgColor: UIColor) {
        if let textField: UITextField = jjc_textField() {
            textField.backgroundColor = bgColor
        }
    }
    
    /// UISearchBar - 设置当前 TextField 的圆角、边框、阴影：radius、width、color、shadowColor、shadowOffset、shadowOpacity、shadowRadius
    public func jjc_textField(radius: CGFloat,
                              borderWidth: CGFloat? = nil,
                              borderColor: UIColor? = nil,
                              shadowColor: UIColor? = nil,
                              shadowOffset: CGSize? = nil,
                              shadowOpacity: Float? = nil,
                              shadowRadius: CGFloat? = nil) {
        if let textField: UITextField = jjc_textField() {
            textField.borderStyle = .none
            textField.layer.cornerRadius = radius
            textField.layer.masksToBounds = true
            if let newBorderWidth = borderWidth {
                textField.layer.borderWidth = newBorderWidth
            }
            if let newBorderColor = borderColor {
                textField.layer.borderColor = newBorderColor.cgColor
            }
            if shadowColor != nil || shadowOffset != nil || shadowOpacity != nil || shadowRadius != nil {
                textField.layer.masksToBounds = false
                if let newShadowColor = shadowColor {
                    textField.layer.shadowColor = newShadowColor.cgColor
                }
                if let newShadowOffset = shadowOffset {
                    textField.layer.shadowOffset = newShadowOffset
                }
                if let newShadowOpacity = shadowOpacity {
                    textField.layer.shadowOpacity = newShadowOpacity
                }
                if let newShadowRadius = shadowRadius {
                    textField.layer.shadowRadius = newShadowRadius
                }
            }
        }
    }
}
