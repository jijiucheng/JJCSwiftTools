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

// MARK:- 设置图文相对位置
extension UIButton {
    
    /// UIButton - 更新图文相对位置
    public func jjc_layoutButtonStyle(style: UIButtonStyle, margin: CGFloat) {
        DispatchQueue.main.async {
            guard let imageView: UIImageView = self.imageView else {
                return
            }
            guard let titleLabel: UILabel = self.titleLabel else {
                return
            }
            
            let imageWidth: CGFloat = imageView.intrinsicContentSize.width
            let imageHeight: CGFloat = imageView.intrinsicContentSize.height
            
            var labelWidth: CGFloat = titleLabel.intrinsicContentSize.width
            if style == .top || style == .bottom {
                labelWidth = titleLabel.intrinsicContentSize.width
            } else {
                labelWidth = labelWidth > titleLabel.jjc_width ? titleLabel.jjc_width : labelWidth
            }
            let labelHeight: CGFloat = titleLabel.intrinsicContentSize.height
            var imageEdgeInsets: UIEdgeInsets = .zero
            var labelEdgeInsets: UIEdgeInsets = .zero

            switch style {
            case .top:
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight - margin * 0.5,
                                               left: labelWidth * 0.5 + margin * 0.5,
                                               bottom: 0,
                                               right: 0)
                labelEdgeInsets = UIEdgeInsets(top: 0,
                                               left: -imageWidth,
                                               bottom: -imageHeight - margin * 0.5,
                                               right: 0)
            case .left:
                imageEdgeInsets = UIEdgeInsets(top: 0,
                                               left: -margin * 0.5,
                                               bottom: 0,
                                               right: margin * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: 0,
                                               left: margin * 0.5,
                                               bottom: 0,
                                               right: -margin * 0.5)
            case .bottom:
                imageEdgeInsets = UIEdgeInsets(top: labelHeight + margin * 0.5,
                                               left: labelWidth * 0.5 + margin * 0.5,
                                               bottom: 0,
                                               right: 0)
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight - margin * 0.5,
                                               left: -imageWidth,
                                               bottom: 0,
                                               right: 0)
            case .right:
                imageEdgeInsets = UIEdgeInsets(top: 0,
                                               left: labelWidth + margin * 0.5,
                                               bottom: 0,
                                               right: -labelWidth - margin * 0.5)
                labelEdgeInsets = UIEdgeInsets(top: 0,
                                               left: -imageWidth - margin * 0.5,
                                               bottom: 0,
                                               right: imageWidth + margin * 0.5)
            }
            
            self.titleEdgeInsets = labelEdgeInsets
            self.imageEdgeInsets = imageEdgeInsets
            self.setNeedsDisplay()
        }
    }
}
