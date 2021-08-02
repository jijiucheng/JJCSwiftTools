//
//  JJCPrivateAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/30.
//


/**
 * 该文件 API 仅限于 JJCSwiftTools 的 framework 内部使用，不建议外部调用
 */


import Foundation


/// 本地语言 - 带注释（Bundle 文件）
///
fileprivate class JJCSwiftToolsBundle {}
public func JJC_Local_private(_ key: String, _ comment: String? = nil, bundle: String) -> String {
    let bundlePath = Bundle(for: JJCSwiftToolsBundle.self).path(forResource: bundle, ofType: "bundle") ?? ""
    if let mainBundle = Bundle(path: bundlePath) {
        // 获取当前本地语言
        let language = Locale.preferredLanguages.first ?? "en"
        var tempLanguage: String?
        // 获取当前 bundle 文件中所有本地语言
        let languages = mainBundle.localizations
        // 1、先查询是否有完全同名语言文件
        for string in languages {
            if language == string {
                tempLanguage = string
                break
            }
        }
        // 2、如果查询不到同名语言文件，则遍历查询获取第一个包含前缀的
        if tempLanguage == nil {
            for string in languages {
                if language.hasPrefix(string) {
                    tempLanguage = string
                    break
                }
            }
        }
        // 3、如果仍查询不到相同前缀的，则取当前语言首字符（国家缩写）进行匹配
        if tempLanguage == nil {
            if let languageHasPre = language.components(separatedBy: "-").first {
                for string in languages {
                    if string.hasPrefix(languageHasPre) {
                        tempLanguage = string
                        break
                    }
                }
            }
        }
        // 4、如果以上仍什么都查找不到，将其置为 en
        if tempLanguage == nil {
            tempLanguage = "en"
        }
        
        if let lprojPath = mainBundle.path(forResource: tempLanguage, ofType: "lproj") {
            if Bundle(path: lprojPath) != nil {
                if let languageBundle = Bundle(path: mainBundle.path(forResource: tempLanguage, ofType: "lproj") ?? "") {
                    return languageBundle.localizedString(forKey: key, value: key, table: nil)
                }
            }
        }
    }
    return ""
}

/// 本地语言 - 带注释（Bundle 文件）
public func JJC_LocalBundle_private(_ key: String, _ comment: String? = nil) -> String {
    return JJC_Local_private(key, comment, bundle: "JJCSwiftTools")
}
