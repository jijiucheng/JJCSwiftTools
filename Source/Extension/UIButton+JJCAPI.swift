//
//  UIButton+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/27.
//

import Foundation
import UIKit

// MARK:- 设置属性 - 图片相关
extension UIButton {
    
    /// UIButton - 设置属性：image、selectImage、highlightImage、horizontalAlignment、verticalAlignment
    public func jjc_params(image: UIImage? = nil,
                           selectImage: UIImage? = nil,
                           highlightedImage: UIImage? = nil,
                           horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                           verticalAlignment: UIControl.ContentVerticalAlignment? = nil) {
        if let newImage = image {
            setImage(newImage, for: .normal)
        }
        if let newSelectImage = selectImage {
            setImage(newSelectImage, for: .selected)
        }
        if let newHighlightedImage = highlightedImage {
            setImage(newHighlightedImage, for: .highlighted)
        }
        adjustsImageWhenHighlighted = false
        if let newHorizontalAlignment = horizontalAlignment {
            contentHorizontalAlignment = newHorizontalAlignment
        }
        if let newVerticalAlignment = verticalAlignment {
            contentVerticalAlignment = newVerticalAlignment
        }
    }
}

// MARK:- 设置属性 - 文字相关
extension UIButton {
    
    /// UIButton - 设置属性：title、titleColor、font、state、horizontalAlignment、verticalAlignment
    public func jjc_params(title: String?,
                           titleColor: UIColor?,
                           font: UIFont?,
                           state: UIControl.State? = .normal,
                           horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                           verticalAlignment: UIControl.ContentVerticalAlignment? = nil) {
        if let newTitle = title {
            setTitle(newTitle, for: state ?? .normal)
        }
        if let newTitleColor = titleColor {
            setTitleColor(newTitleColor, for: state ?? .normal)
        }
        if let newFont = font {
            titleLabel?.font = newFont
        }
        if let newHorizontalAlignment = horizontalAlignment {
            contentHorizontalAlignment = newHorizontalAlignment
        }
        if let newVerticalAlignment = verticalAlignment {
            contentVerticalAlignment = newVerticalAlignment
        }
    }
    
    /// UIButton - 设置属性：title、titleColor、fontSize、weight、state、horizontalAlignment、verticalAlignment
    public func jjc_params(title: String?,
                           titleColor: UIColor?,
                           fontSize: CGFloat?,
                           weight: UIFont.Weight? = .regular,
                           state: UIControl.State? = .normal,
                           horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                           verticalAlignment: UIControl.ContentVerticalAlignment? = nil) {
        var font: UIFont?
        if let newFontSize = fontSize {
            font = .systemFont(ofSize: newFontSize, weight: weight ?? .regular)
        }
        jjc_params(title: title,
                   titleColor: titleColor,
                   font: font,
                   state: state,
                   horizontalAlignment: horizontalAlignment,
                   verticalAlignment: verticalAlignment)
    }
    
    /// UIButton - 设置属性：title、titleColor、fontSize、fontFamily、state、horizontalAlignment、verticalAlignment
    public func jjc_params(title: String?,
                           titleColor: UIColor?,
                           fontSize: CGFloat?,
                           fontFamily: String?,
                           state: UIControl.State? = .normal,
                           horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                           verticalAlignment: UIControl.ContentVerticalAlignment? = nil) {
        var font: UIFont?
        if let newFontSize = fontSize {
            if let newFontFamily = fontFamily {
                font = UIFont(name: newFontFamily, size: newFontSize)
            }
            font = UIFont(name: "", size: newFontSize)
        }
        jjc_params(title: title,
                   titleColor: titleColor,
                   font: font,
                   state: state,
                   horizontalAlignment: horizontalAlignment,
                   verticalAlignment: verticalAlignment)
    }
}
