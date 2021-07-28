//
//  CALayer+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- 扩展 CALayer 圆角、边框、阴影相关方法
extension CALayer {
    
    /// CALayer - 设置圆角、边框、阴影：radius、borderWidth、borderColor、shadowColor、shadowOffset、shadowOpacity、shadowRadius
    public func jjc_radiusBorderShadow(radius: CGFloat,
                                       borderWidth: CGFloat? = nil,
                                       borderColor: UIColor? = nil,
                                       shadowColor: UIColor? = nil,
                                       shadowOffset: CGSize? = nil,
                                       shadowOpacity: Float? = nil,
                                       shadowRadius: CGFloat? = nil) {
        self.cornerRadius = radius
        self.masksToBounds = true
        if let newBorderWidth = borderWidth {
            self.borderWidth = newBorderWidth
        }
        if let newBorderColor = borderColor {
            self.borderColor = newBorderColor.cgColor
        }
        if shadowColor != nil || shadowOffset != nil || shadowOpacity != nil || shadowRadius != nil {
            self.masksToBounds = false
            if let newShadowColor = shadowColor {
                self.shadowColor = newShadowColor.cgColor
            }
            if let newShadowOffset = shadowOffset {
                self.shadowOffset = newShadowOffset
            }
            if let newShadowOpacity = shadowOpacity {
                self.shadowOpacity = newShadowOpacity
            }
            if let newShadowRadius = shadowRadius {
                self.shadowRadius = newShadowRadius
            }
        }
    }
    
    /// CALayer - 设置圆角、边框：radius、borderWidth、borderColor
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
    
    /// CALayer - 设置圆角：radius
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
