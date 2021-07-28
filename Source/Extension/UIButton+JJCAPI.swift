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
    
    /// UIButton - 设置属性：title、titleColor、font、fontFamily、fontSize、weight、state、horizontalAlignment、verticalAlignment
    /// 注意：font、（fontFamily、fontSize）、（fontSize、weight）三者设置一种即可，其它的设置为 nil
    public func jjc_params(title: String?,
                           titleColor: UIColor? = nil,
                           font: UIFont? = nil,
                           fontFamily: String? = nil,
                           fontSize: CGFloat? = nil,
                           weight: UIFont.Weight? = nil,
                           state: UIControl.State? = nil,
                           horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                           verticalAlignment: UIControl.ContentVerticalAlignment? = nil) {
        if let newTitle = title {
            setTitle(newTitle, for: state ?? .normal)
        }
        if let newTitleColor = titleColor {
            setTitleColor(newTitleColor, for: state ?? .normal)
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
        titleLabel?.font = tempFont
        
        if let newHorizontalAlignment = horizontalAlignment {
            contentHorizontalAlignment = newHorizontalAlignment
        }
        if let newVerticalAlignment = verticalAlignment {
            contentVerticalAlignment = newVerticalAlignment
        }
    }
}
