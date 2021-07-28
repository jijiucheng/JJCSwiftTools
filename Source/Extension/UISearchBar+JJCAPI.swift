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
    
    /// UISearchBar - 获取当前 TextField
    public func jjc_textField() -> UITextField? {
        if self.value(forKey: "searchField") is UITextField {
            let textField: UITextField = self.value(forKey: "searchField") as! UITextField
            return textField
        }
        return nil
    }
    
    /// UISearchBar - 设置当前 TextField 的背景色
    public func jjc_textField(backgroundColor: UIColor) {
        if let textField: UITextField = jjc_textField() {
            textField.backgroundColor = backgroundColor
        }
    }
    
    /// UISearchBar - 设置当前 TextField 的圆角、边框
    public func jjc_textField(radius: CGFloat, width: CGFloat, color: UIColor) {
        if let textField: UITextField = jjc_textField() {
            textField.borderStyle = .none
            textField.layer.cornerRadius = radius
            textField.layer.masksToBounds = true
            textField.layer.borderWidth = width
            textField.layer.borderColor = color.cgColor
        }
    }
    
    /// UISearchBar - 设置当前 TextField 的圆角
    public func jjc_textField(radius: CGFloat) {
        if let textField: UITextField = jjc_textField() {
            textField.borderStyle = .none
            textField.layer.cornerRadius = radius
            textField.layer.masksToBounds = true
        }
    }
}
