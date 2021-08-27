//
//  UIImage+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/28.
//

import Foundation
import UIKit

// MARK:- UIImage 转换方法
extension UIImage {
    
    /// UIImage - 图片转 String
    public func jjc_toBase64String(_ isPNG: Bool? = false) -> String? {
        if let data: Data = (isPNG ?? false) ? self.pngData() : self.jpegData(compressionQuality: 1.0) {
            return data.base64EncodedString(options: .lineLength64Characters)
        }
        return nil
    }
    
    /// UIImage - 颜色转图片
    public static func jjc_getImage(color: UIColor?) -> UIImage? {
        if let newColor = color {
            let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(newColor.cgColor)
            context!.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    /// UIImage - 根据 UIView 生成图片
    public static func jjc_getImage(view: UIView?) -> UIImage? {
        if let newView = view {
            UIGraphicsBeginImageContext(newView.bounds.size)
            newView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}
