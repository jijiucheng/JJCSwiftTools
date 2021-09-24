//
//  JJCLocal.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/9/22.
//

import UIKit
import Foundation

public class JJCLocal: NSObject {
    
    /// JJCLocal - 定义语言返回参数
    /// - localCode：当前语言编码
    /// - code：指定语言编码
    /// - showName：根据当前语言编码获取指定语言编码对应的语言名称
    /// - name：根据指定语言编码获取指定语言编码对应的语言名称
    /// - note：备注说明
    /**
     例如：
     1、当 App 内部设置为 zh-Hans 语言，则返回 [(zh-Hans, en, 英语, English), (zh-Hans, zh-Hans, 简体中文, 简体中文), (zh-Hans, zh-Hant, 繁体中文, 繁體中文), ...]；
     2、当 App 内部设置为 en 语言，则返回 [(en, en, English, English), (en, zh-Hans, Chinese Smiplified, 简体中文), (en, zh-Hant, Chinese Traditional, 繁體中文), ...]；
     */
    public typealias JJCLanguageParams = (localCode: String,
                                          code: String,
                                          showName: String?,
                                          name: String?,
                                          note: String?)
}

// MARK:- Language
extension JJCLocal {
    
    /// JJCLocal - 类方法 - 获取系统所有本地化标识符数组列表
    public static func jjc_systemAllAvailableLanguages() -> [String] {
        return Locale.availableIdentifiers
    }

    /// JJCLocal - 类方法 - 获取当前手机系统已添加全部语言【设置->通用->语言->首选语言顺序】
    /// - 此处也可以通过 UserDefaults.standard.value(forKey: "AppleLanguages") 获取
    public static func jjc_systemAllLanguages() -> [String] {
        return Locale.preferredLanguages
    }
    
    /// JJCLocal - 类方法 - 获取当前手机系统语言【设置->通用->语言->首选语言顺序】
    /// - 此处也可以通过 UserDefaults.standard.value(forKey: "AppleLanguages") 获取
    public static func jjc_systemLanguage() -> String {
        return Locale.preferredLanguages.first ?? "en"
    }
    
    /// JJCLocal - 类方法 - 根据系统所有本地化标识符获取某语言显示对应语言名称（官方命名）
    /// - showId：以该种语言显示获取的结果
    /// - languageId：需要展示名称的语言
    /**
     例如：
     1、使用 zh-Hans 显示 en-CN 为 英语（中国大陆）；
     2、使用 en-CN 显示 zh-Hans 为 Chinese, Simplified；
     */
    public static func jjc_languageName(_ showId: String, _ languageId: String) -> String? {
        return Locale(identifier: showId).localizedString(forIdentifier: languageId)
    }
    
    /// JJCLocal - 类方法 - 根据系统本地化指定语言获取当前 App 内置所有语言环境
    /// - 返回参数：[(当前内置语言编码 code, 语言编码 code, 当前语言下该语言编码名称, 该语言编码语言环境下该语言编码名称)]
    public static func jjc_languages(_ bundle: Bundle = Bundle.main) -> [JJCLanguageParams] {
        let languages: [String] = bundle.localizations
        let curLanguage: String = JJCLocal.jjc_language(bundle)
        var tupleLanguages = [JJCLanguageParams]()
        for language in languages {
            let tuple: JJCLanguageParams = (curLanguage,
                                            language,
                                            Locale(identifier: curLanguage).localizedString(forIdentifier: language),
                                            Locale(identifier: language).localizedString(forIdentifier: language),
                                            nil)
            tupleLanguages.append(tuple)
        }
        return tupleLanguages
    }
    
    /// JJCLocal - 类方法 - 根据某一语言返回对应语言相关信息（同 jjc_languages 返回值）
    public static func jjc_language(_ bundle: Bundle = Bundle.main, lproj: String) -> JJCLanguageParams {
        let languages: [String] = bundle.localizations
        let curLanguage: String = JJCLocal.jjc_language(bundle)
        var tupleLanguage: JJCLanguageParams = (curLanguage,
                                                lproj,
                                                Locale(identifier: curLanguage).localizedString(forIdentifier: lproj),
                                                Locale(identifier: lproj).localizedString(forIdentifier: lproj),
                                                nil)
        for language in languages {
            if curLanguage == language {
                tupleLanguage = (curLanguage,
                                 lproj,
                                 Locale(identifier: curLanguage).localizedString(forIdentifier: lproj),
                                 Locale(identifier: lproj).localizedString(forIdentifier: lproj),
                                 nil)
                break
            }
        }
        return tupleLanguage
    }
    
    /// JJCLocal - 类方法 - 获取当前语言环境（根据 Bundle 获取 lproj 的语言文件）
    /// - 参考链接：https://www.jianshu.com/p/1199cda9c61b
    public static func jjc_language(_ bundle: Bundle = Bundle.main) -> String {
        // 1、获取当前本地语言
        let language = bundle.preferredLocalizations.first ?? "en"
        var targetLanguage: String?
        // 2、获取当前 bundle 文件中所有本地语言
        let languages = bundle.localizations
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
        return targetLanguage ?? "en"
    }
    
    /// JJCLocal - 类方法 - 本地语言 - 带注释（根据 Bundle 获取 lproj 的语言文件）
    public static func jjc_local(_ key: String, _ comment: String? = nil, bundle: Bundle = Bundle.main, lproj: String? = nil) -> String {
        var newLproj: String = JJCLocal.jjc_language(bundle)
        if let tempLproj: String = lproj {
            newLproj = tempLproj
        }
        if let lprojPath = bundle.path(forResource: newLproj, ofType: "lproj") {
            if Bundle(path: lprojPath) != nil {
                if let languageBundle = Bundle(path: bundle.path(forResource: newLproj, ofType: "lproj") ?? "") {
                    return languageBundle.localizedString(forKey: key, value: key, table: nil)
                }
            }
        }
        return NSLocalizedString(key, comment: comment ?? key)
    }

    /// JJCLocal - 类方法 - 本地语言 - 带注释（根据 Bundle 获取）
    /// - bundle 和 objClass 两个参数需同时传递，且 objClass 必须为对应 bundle 所在 Module 任一 class 对象
    /// - objClass 设计原因是 Bundle 的 public init(for aClass: AnyClass) 方法，根据某个类获取当前工程下的主 Bundle，如果不进行如此操作，获取的就是 Demo 工程里的 Main Bundle
    /// - 参考链接：https://www.jianshu.com/p/b64ff9d8e7ce、https://www.jianshu.com/p/173076faa742
    public static func jjc_local(byBundle key: String, _ comment: String? = nil, bundleName: String? = nil, objClass: AnyClass? = nil, lproj: String? = nil) -> String {
        if let newBundleName: String = bundleName, let newObjClass: AnyClass = objClass {
            let bundlePath = Bundle(for: newObjClass).path(forResource: newBundleName, ofType: "bundle") ?? ""
            if let mainBundle = Bundle(path: bundlePath) {
                return JJCLocal.jjc_local(key, comment, bundle: mainBundle, lproj: lproj)
            }
        }
        return NSLocalizedString(key, comment: comment ?? key)
    }
    
    /// JJCLocal - 类方法 - 当前语言环境是否是中文
    /// - 返回参数一：是否是中文；
    /// - 返回参数二：当前语言环境
    public static func jjc_isChinese(_ bundle: Bundle = Bundle.main) -> (isChinese: Bool, language: String) {
        let preferredLang = JJCLocal.jjc_language(bundle)
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return (false, preferredLang)
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans","zh-Hant":
            return (true, preferredLang)
        default:
            return (false, preferredLang)
        }
    }
}
