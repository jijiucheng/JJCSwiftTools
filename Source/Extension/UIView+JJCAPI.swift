//
//  UIView+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 扩展 UIView 位置尺寸
extension UIView {
    
    /// UIView - 距离顶部间距 y
    public var jjc_top: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    
    /// UIView - 距离左侧间距 x
    public var jjc_left: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }
    
    /// UIView - 距离底部间距 y + height
    public var jjc_bottom: CGFloat {
        set { frame.origin.y = newValue - frame.size.height }
        get { return (frame.origin.y + frame.size.height) }
    }
    
    /// UIView - 距离右侧间距 x + width
    public var jjc_right: CGFloat {
        set { frame.origin.x = newValue - frame.size.width }
        get { return (frame.origin.x + frame.size.width) }
    }
    
    /// UIView - 中心点 x
    public var jjc_centerX: CGFloat {
        set { center.x = newValue }
        get { return center.x }
    }
    
    /// UIView - 中心点 y
    public var jjc_centerY: CGFloat {
        set { center.y = newValue }
        get { return center.y }
    }
    
    /// UIView - 距离左侧间距 x
    public var jjc_x: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }

    /// UIView - 距离顶部间距 y
    public var jjc_y: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    
    /// UIView - 宽度
    public var jjc_width: CGFloat {
        set { frame.size.width = newValue }
        get { return frame.size.width }
    }
    
    /// UIView - 高度
    public var jjc_height: CGFloat {
        set { frame.size.height = newValue }
        get { return frame.size.height }
    }
    
    /// UIView - 左上角坐标
    public var jjc_origin: CGPoint {
        set { frame.origin = newValue }
        get { return frame.origin }
    }
    
    /// UIView - 宽高尺寸
    public var jjc_size: CGSize {
        set { frame.size = newValue }
        get { return frame.size }
    }
}

// MARK:- 扩展 UIView 圆角、边框、阴影相关方法
extension UIView {
    
    /// UIView - 设置圆角、边框、阴影：radius、borderWidth、borderColor、shadowColor、shadowOffset、shadowOpacity、shadowRadius
    public func jjc_radiusBorderShadow(radius: CGFloat,
                                       borderWidth: CGFloat? = nil,
                                       borderColor: UIColor? = nil,
                                       shadowColor: UIColor? = nil,
                                       shadowOffset: CGSize? = nil,
                                       shadowOpacity: Float? = nil,
                                       shadowRadius: CGFloat? = nil) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        if let newBorderWidth = borderWidth {
            layer.borderWidth = newBorderWidth
        }
        if let newBorderColor = borderColor {
            layer.borderColor = newBorderColor.cgColor
        }
        if shadowColor != nil || shadowOffset != nil || shadowOpacity != nil || shadowRadius != nil {
            layer.masksToBounds = false
            if let newShadowColor = shadowColor {
                layer.shadowColor = newShadowColor.cgColor
            }
            if let newShadowOffset = shadowOffset {
                layer.shadowOffset = newShadowOffset
            }
            if let newShadowOpacity = shadowOpacity {
                layer.shadowOpacity = newShadowOpacity
            }
            if let newShadowRadius = shadowRadius {
                layer.shadowRadius = newShadowRadius
            }
        }
    }
    
    /// UIView - 设置圆角、边框：radius、borderWidth、borderColor
    public func jjc_radiusBorder(radius: CGFloat,
                                 borderWidth: CGFloat? = nil,
                                 borderColor: UIColor? = nil) {
        jjc_radiusBorderShadow(radius: radius,
                               borderWidth: borderWidth,
                               borderColor: borderColor,
                               shadowColor: nil,
                               shadowOffset: nil,
                               shadowOpacity: nil,
                               shadowRadius: nil)
    }
    
    /// UIView - 设置圆角：radius
    public func jjc_radius(radius: CGFloat) {
        jjc_radiusBorderShadow(radius: radius,
                               borderWidth: nil,
                               borderColor: nil,
                               shadowColor: nil,
                               shadowOffset: nil,
                               shadowOpacity: nil,
                               shadowRadius: nil)
    }
}
