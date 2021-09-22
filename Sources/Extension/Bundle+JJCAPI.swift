//
//  Bundle+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/2.
//

import Foundation
import UIKit

// MARK:- Bundle - 获取资源文件
extension Bundle {
    
    /// Bundle - 类方法 - 根据 bundle 名称获取对应 Bundle
    public static func jjc_bundle(_ bundle: String) -> Bundle? {
        if let bundlePath = Bundle.main.path(forResource: bundle, ofType: "bundle") {
            return Bundle(path: bundlePath)
        }
        return nil
    }
    
    /// Bundle - 类方法 - 根据 bundle 名称获取对应内部资源文件路径
    public static func jjc_bundleFile(resource: String, ofType type: String, bundle: String) -> String? {
        if let mainBundle = Bundle.jjc_bundle(bundle) {
            return mainBundle.path(forResource: resource, ofType: type)
        }
        return nil
    }
    
    /// Bundle - 类方法 - 根据 bundle 名称获取对应内部图片文件路径
    public static func jjc_bundleImage(resource: String, ofType type: String, bundle: String) -> UIImage? {
        if let mainBundle = Bundle.jjc_bundle(bundle) {
            if let filePath = mainBundle.path(forResource: resource, ofType: type) {
                // resource - back@2x
                return UIImage(contentsOfFile: filePath)
//                // resource - back
//                return UIImage(named: resource, in: mainBundle, compatibleWith: nil)
            }
        }
        return nil
    }
}
