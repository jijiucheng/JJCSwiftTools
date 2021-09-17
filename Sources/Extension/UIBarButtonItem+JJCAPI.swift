//
//  UIBarButtonItem+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/9/14.
//

import Foundation
import UIKit

// MARK:- UIBarButtonItem 扩展存储属性
extension UIBarButtonItem {
    
    /// UIBarButtonItem -
    private struct AssociatedKey {
        static var itemWidth: CGFloat = 30.0
        static var itemHeight: CGFloat = 30.0
    }
    
    /// UIBarButtonItem - 导航栏按钮宽度
    public var jjc_itemWidth: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKey.itemWidth) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKey.itemWidth, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// UIBarButtonItem - 导航栏按钮高度
    public var jjc_itemHeight: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKey.itemHeight) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKey.itemHeight, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
}

// MARK:- UIBarButtonItem 扩展方法
extension UIBarButtonItem {
    
    /// UIBarButtonItem - 初始化导航栏按钮（图片）
    public static func jjc_params(frame: CGRect? = nil,
                                  image: UIImage,
                                  contentInsets: UIEdgeInsets? = nil,
                                  horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                                  target: Any?,
                                  action: Selector) -> UIBarButtonItem {
        /**
        customView 类型，需要传递的是 view，才可以控制 btn 的大小尺寸
        https://www.jianshu.com/p/ba796cf1c15f
        */
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        if let buttonViewFrame = frame {
            buttonView.frame = buttonViewFrame
        }

        let button = UIButton(type: .custom)
        button.frame = buttonView.bounds
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.adjustsImageWhenHighlighted = false
        if let newContentInsets = contentInsets {
            button.imageEdgeInsets = newContentInsets
        }
        if let newHorizontalAlignment = horizontalAlignment {
            button.contentHorizontalAlignment = newHorizontalAlignment
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        buttonView.addSubview(button)
    
        return UIBarButtonItem(customView: buttonView)
    }
    
    /// UIBarButtonItem - 初始化导航栏按钮（文字）
    public static func jjc_params(frame: CGRect? = nil,
                                  title: String,
                                  color: UIColor,
                                  font: UIFont,
                                  contentInsets: UIEdgeInsets? = nil,
                                  horizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
                                  target: Any?,
                                  action: Selector) -> UIBarButtonItem {
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        if let buttonViewFrame = frame {
            buttonView.frame = buttonViewFrame
        }

        let button = UIButton(type: .custom)
        button.frame = buttonView.bounds
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        if let newContentInsets = contentInsets {
            button.titleEdgeInsets = newContentInsets
        }
        if let newHorizontalAlignment = horizontalAlignment {
            button.contentHorizontalAlignment = newHorizontalAlignment
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        buttonView.addSubview(button)
    
        return UIBarButtonItem(customView: buttonView)
    }
    
    /// UIBarButtonItem - 初始化导航栏按钮（文字）（简版）
    public static func jjc_params(title: String,
                                  target: Any?,
                                  action: Selector) -> UIBarButtonItem {
        
        var font = UIFont.systemFont(ofSize: 14)
        if title.count > 3 {
            font = UIFont.systemFont(ofSize: 11)
        }
        return jjc_params(title: title, color: .darkGray, font: font, target: target, action: action)
    }
}
