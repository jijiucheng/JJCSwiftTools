//
//  CGRect+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 设置 CGRect 属性
extension CGRect {
    
    /// CGRect - 获取 宽度为屏幕宽度，高度为 0 的 CGRect
    public static func jjc_zeroScreenWidth() -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0)
    }
    
    /// CGRect - 获取 高度为屏幕高度，宽度为 0 的 CGRect
    public static func jjc_zeroScreenHeight() -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.size.height)
    }
    
    /// CGRect - 获取 宽度为指定宽度，高度为 0 的 CGRect
    public static func jjc_zeroWidth(_ width: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: width, height: 0)
    }
    
    /// CGRect - 获取 高度为指定高度，宽度为 0 的 CGRect
    public static func jjc_zeroHeight(_ height: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: height)
    }
}
