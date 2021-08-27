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

// MARK:- Bundle - 语言环境
extension Bundle {
    
    /// Bundle - 类方法 - 获取当前所有语言环境
    public static func jjc_languages() -> [String] {
        return Bundle.main.localizations
    }
    
    /// Bundle - 类方法 - 当前语言环境
    public static func jjc_language() -> String {
        return Bundle.main.preferredLocalizations.first ?? "en"
    }

    /// Bundle - 类方法 - 获取当前语言环境（根据 Bundle 获取 lproj 的语言文件）
    public static func jjc_language(bundle: Bundle) -> String {
        // 1、获取当前本地语言
        let language = Bundle.jjc_language()
        var targetLanguage: String?
        // 2、获取当前 bundle 文件中所有本地语言
        let languages = Bundle.jjc_languages()
        // 3.1、先查询是否有完全同名语言文件
        for string in languages {
            if language == string {
                targetLanguage = string
                break
            }
        }
        // 3.2、如果查询不到同名语言文件，则遍历查询获取第一个包含前缀的
        if targetLanguage == nil {
            for string in languages {
                if language.hasPrefix(string) {
                    targetLanguage = string
                    break
                }
            }
        }
        // 3.3、如果仍查询不到相同前缀的，则取当前语言首字符（国家缩写）进行匹配
        if targetLanguage == nil {
            if let languageHasPre = language.components(separatedBy: "-").first {
                for string in languages {
                    if string.hasPrefix(languageHasPre) {
                        targetLanguage = string
                        break
                    }
                }
            }
        }
        // 3.4、如果以上仍什么都查找不到，将其置为 en
        if targetLanguage == nil {
            targetLanguage = "en"
        }
        
        return targetLanguage ?? "en"
    }

    /// Bundle - 类方法 - 当前语言环境是否是中文
    /// 返回参数一：是否是中文；
    /// 返回参数二：当前语言环境
    public static func jjc_isChinese() -> (Bool, String) {
        let preferredLang = Bundle.jjc_language()
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return (false, preferredLang)
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return (true, preferredLang)
        default:
            return (false, preferredLang)
        }
    }

    /// Bundle - 类方法 - 本地语言 - 带注释
    public static func jjc_local(_ key: String, _ comment: String? = nil) -> String {
        return NSLocalizedString(key, comment: comment ?? "")
    }

    /// Bundle - 类方法 - 本地语言 - 带注释（根据 Bundle 获取 lproj 的语言文件）
    public static func jjc_local(_ key: String, _ comment: String? = nil, bundle: Bundle) -> String {
        if let lprojPath = bundle.path(forResource: Bundle.jjc_language(bundle: bundle), ofType: "lproj") {
            if Bundle(path: lprojPath) != nil {
                if let languageBundle = Bundle(path: bundle.path(forResource: Bundle.jjc_language(bundle: bundle), ofType: "lproj") ?? "") {
                    return languageBundle.localizedString(forKey: key, value: key, table: nil)
                }
            }
        }
        return ""
    }
}
