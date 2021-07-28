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
    
    /// UIButton - 设置属性：image、selectImage、highlightImage
    public func jjc_params(image: UIImage?, selectImage: UIImage?, highlightImage: UIImage?) {
        if let newImage = image {
            setImage(newImage, for: .normal)
        }
        if let newSelectImage = selectImage {
            setImage(newSelectImage, for: .selected)
        }
        if let newHighlightImage = highlightImage {
            setImage(newHighlightImage, for: .highlighted)
        }
        adjustsImageWhenHighlighted = false
    }
    
    /// UIButton - 设置属性：image、selectImage
    public func jjc_params(image: UIImage?, selectImage: UIImage?) {
        jjc_params(image: image, selectImage: selectImage, highlightImage: nil)
    }
    
    /// UIButton - 设置属性：image
    public func jjc_params(image: UIImage?) {
        jjc_params(image: image, selectImage: nil, highlightImage: nil)
    }
    
    /// UIButton - 设置属性：selectImage
    public func jjc_params(selectImage: UIImage?) {
        jjc_params(image: nil, selectImage: selectImage, highlightImage: nil)
    }
    
    /// UIButton - 设置属性：highlightImage
    public func jjc_params(highlightImage: UIImage?) {
        jjc_params(image: nil, selectImage: nil, highlightImage: highlightImage)
    }
}

// MARK:- 设置属性 - 文字相关
extension UIButton {
    
    /// UIButton - 设置属性：title、titleColor、font、state
    public func jjc_params(title: String?, titleColor: UIColor?, font: UIFont?, state: UIControl.State? = .normal) {
        if let newTitle = title {
            setTitle(newTitle, for: state ?? .normal)
        }
        if let newTitleColor = titleColor {
            setTitleColor(newTitleColor, for: state ?? .normal)
        }
        if let newFont = font {
            titleLabel?.font = newFont
        }
    }
    
    /// UIButton - 设置属性：title、titleColor、fontSize、weight、state
    public func jjc_params(title: String, titleColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight, state: UIControl.State) {
        jjc_params(title: title, titleColor: titleColor, font: .systemFont(ofSize: fontSize, weight: weight), state: state)
    }
    
    /// UIButton - 设置属性：title、titleColor、font
    public func jjc_params(title: String, titleColor: UIColor, font: UIFont) {
        jjc_params(title: title, titleColor: titleColor, font: font, state: .normal)
    }
    
    /// UIButton - 设置属性：title、titleColor、fontSize、weight
    public func jjc_params(title: String, titleColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight) {
        jjc_params(title: title, titleColor: titleColor, font: .systemFont(ofSize: fontSize, weight: weight), state: .normal)
    }
    
    /// UIButton - 设置属性：title、titleColor、fontSize
    public func jjc_params(title: String, titleColor: UIColor, fontSize: CGFloat) {
        jjc_params(title: title, titleColor: titleColor, font: .systemFont(ofSize: fontSize, weight: .regular), state: .normal)
    }
    
    /// UIButton - 设置属性：selectTitle、selectTitleColor、font
    public func jjc_params(selectTitle: String, selectTitleColor: UIColor, font: UIFont) {
        jjc_params(title: selectTitle, titleColor: selectTitleColor, font: font, state: .selected)
    }
    
    /// UIButton - 设置属性：selectTitle、selectTitleColor、fontSize、weight
    public func jjc_params(selectTitle: String, selectTitleColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight) {
        jjc_params(title: selectTitle, titleColor: selectTitleColor, font: .systemFont(ofSize: fontSize, weight: weight), state: .selected)
    }
    
    /// UIButton - 设置属性：selectTitle、selectTitleColor、fontSize
    public func jjc_params(selectTitle: String, selectTitleColor: UIColor, fontSize: CGFloat) {
        jjc_params(title: selectTitle, titleColor: selectTitleColor, font: .systemFont(ofSize: fontSize, weight: .regular), state: .selected)
    }
}
