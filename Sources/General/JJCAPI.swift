//
//  JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/29.
//

import Foundation
import UIKit

// MARK:- 全局常量

/// JJCAPI - 屏幕尺寸
public let JJC_ScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
/// JJCAPI - 屏幕宽度
public let JJC_ScreenW = JJC_ScreenSize.width
/// JJCAPI - 屏幕高度
public let JJC_ScreenH = JJC_ScreenSize.height
/// JJCAPI - 导航栏高度
public let JJC_NaviH: CGFloat = 44.0
/// JJCAPI - KeyWindow
public let JJC_KeyWindow: UIWindow = UIApplication.shared.windows[0]

/// JJCAPI - 基础间隙
public let JJC_Margin: CGFloat = 10

/// JJCAPI - 沙盒 Document 路径
public let JJC_DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
/// JJCAPI - 沙盒 Cache 路径
public let JJC_CachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
/// JJCAPI - 沙盒 temp 路径
public let JJC_TempPath = NSTemporaryDirectory()

/// JJCAPI - 是否为 iPhone
public let JJC_IsIPhone = (UIDevice.current.userInterfaceIdiom == .phone)
/// JJCAPI - 是否为 iPad
public let JJC_IsIPad = (UIDevice.current.userInterfaceIdiom == .pad)
/// JJCAPI - 是否为 CarPlay
public let JJC_IsCarPlay = (UIDevice.current.userInterfaceIdiom == .carPlay)

/// JJCAPI - 系统信息 - App 唯一识别号
public let JJC_BundleIdentifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
/// JJCAPI - 系统信息 - App 名称
public let JJC_BundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
/// JJCAPI - 系统信息 - release version
public let JJC_ReleaseVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
/// JJCAPI - 系统信息 - debug version
public let JJC_DebugVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
/// JJCAPI - 系统信息
public let JJC_Version = "\(JJC_ReleaseVersion)(\(JJC_DebugVersion))"


// MARK:- 全局函数

/// JJCAPI - 是否是刘海屏
public func JJC_IsIPhoneX() -> Bool {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
    } else {
        return false
    }
}

/// JJCAPI - 状态栏高度
public func JJC_StatusH() -> CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/// JJCAPI - （状态栏+导航栏）高度
public func JJC_StatusNaviH() -> CGFloat {
    if #available(iOS 13.0, *) {
        return (UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + JJC_NaviH
    } else {
        return UIApplication.shared.statusBarFrame.height + JJC_NaviH
    }
}

/// JJCAPI - 底部 TabBar 高度
public func JJC_TabBarH() -> CGFloat {
    return JJC_IsIPhoneX() ? (49.0 + 34.0) : 49.0
}

/// JJCAPI - 生成随机数
public func JJC_Random(min: Int, max: Int) -> Int {
    return Int.random(in: min...max)
}

/// JJCAPI - 颜色 - RGBA
public func JJC_RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(red: r, green: g, blue: b, alpha: a ?? 1.0)
}

/// JJCAPI - 颜色 - RGBA_255
public func JJC_RGBA_255(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255, blue: b / 255, alpha: a ?? 1.0)
}

/// JJCAPI - 颜色 - HexColorA
public func JJC_HexColorA(_ hexString: String, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(hexString: hexString, alpha: a ?? 1.0)
}

/// JJCAPI - 终端日志 DEBUG - isLineBreak：最后一行是否添加换行
public func JJC_Print<T>(_ log: T, file: String = #file, method: String = #function, line: Int = #line, isLineBreak: Bool = true) {
    #if DEBUG
    print("\(Date()) <\((file as NSString).lastPathComponent)> [\(line)] ---- \(method)：")
    debugPrint(log)
    if isLineBreak {
        print()
    }
    #endif
}

/// JJCAPI - 当前语言（"en-CN"、"zh-Hans"、...）
public func JJC_CurLanguage(_ isSystem: Bool) -> String {
    if isSystem {
        return Locale.preferredLanguages.first ?? "en"
    } else {
        return Bundle.main.localizations.first ?? "en"
    }
}

/// JJCAPI - 本地语言 - 获取当前语言环境（App 内部预置语言）
/// - 参考链接：https://www.jianshu.com/p/1199cda9c61b
public func JJC_Language(_ bundle: Bundle = Bundle.main) -> String {
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

/// JJCAPI - 本地语言 - 根据系统本地化指定语言获取当前 App 内置所有语言环境
/// - 返回参数：[(当前内置语言编码 code, 语言编码 code, 当前语言下该语言编码名称, 该语言编码语言环境下该语言编码名称)]
/**
 例如：
 1、当 App 内部设置为 zh-Hans 语言，则返回 [(zh-Hans, en, 英语, English), (zh-Hans, zh-Hans, 简体中文, 简体中文), (zh-Hans, zh-Hant, 繁体中文, 繁體中文), ...]；
 2、当 App 内部设置为 en 语言，则返回 [(en, en, English, English), (en, zh-Hans, Chinese Smiplified, 简体中文), (en, zh-Hant, Chinese Traditional, 繁體中文), ...]；
 */
public func JJC_Languages(_ bundle: Bundle = Bundle.main) -> [(String, String, String?, String?)] {
    let languages: [String] = bundle.localizations
    let curLanguage: String = JJC_Language(bundle)
    var tupleLanguages = [(String, String, String?, String?)]()
    for language in languages {
        let tuple = (curLanguage,
                     language,
                     Locale(identifier: curLanguage).localizedString(forIdentifier: language),
                     Locale(identifier: language).localizedString(forIdentifier: language))
        tupleLanguages.append(tuple)
    }
    return tupleLanguages
}

/// JJCAPI - 本地语言 - 根据某一语言返回对应语言相关信息（同 jjc_languages 返回值）
public func JJC_Language(_ bundle: Bundle = Bundle.main, lproj: String) -> (String, String, String?, String?) {
    let languages: [String] = bundle.localizations
    let curLanguage: String = Bundle.jjc_language(bundle)
    var tupleLanguage: (String, String, String?, String?) = (curLanguage,
                                                             curLanguage,
                                                             Locale(identifier: curLanguage).localizedString(forIdentifier: curLanguage),
                                                             Locale(identifier: curLanguage).localizedString(forIdentifier: curLanguage))
    for language in languages {
        if curLanguage == language {
            tupleLanguage = (curLanguage,
                             language,
                             Locale(identifier: curLanguage).localizedString(forIdentifier: language),
                             Locale(identifier: language).localizedString(forIdentifier: language))
            break
        }
    }
    return tupleLanguage
}

/// JJCAPI - 本地语言 - 带注释（根据 Bundle 获取 lproj 的语言文件）
public func JJC_Local(_ key: String, _ comment: String? = nil, bundle: Bundle = Bundle.main, lproj: String? = nil) -> String {
    var newLproj: String = Bundle.jjc_language(bundle)
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

/// JJCAPI - 本地语言 - 带注释（根据 Bundle 获取）
/// - bundle 和 objClass 两个参数需同时传递，且 objClass 必须为对应 bundle 所在 Module 任一 class 对象
public func JJC_Local(byBundle key: String, _ comment: String? = nil, bundleName: String? = nil, objClass: AnyClass? = nil, lproj: String? = nil) -> String {
    if let newBundleName: String = bundleName, let newObjClass: AnyClass = objClass {
        let bundlePath = Bundle(for: newObjClass).path(forResource: newBundleName, ofType: "bundle") ?? ""
        if let mainBundle = Bundle(path: bundlePath) {
            return Bundle.jjc_local(key, comment, bundle: mainBundle, lproj: lproj)
        }
    }
    return NSLocalizedString(key, comment: comment ?? key)
}

/// JJCAPI - 本地语言 - 当前语言环境是否是中文
/// - 返回参数一：是否是中文；
/// - 返回参数二：当前语言环境
public func JJC_IsChinese(_ bundle: Bundle = Bundle.main) -> (Bool, String) {
    let preferredLang = Bundle.jjc_language(bundle)
    switch String(describing: preferredLang) {
    case "en-US", "en-CN":
        return (false, preferredLang)
    case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans","zh-Hant":
        return (true, preferredLang)
    default:
        return (false, preferredLang)
    }
}

/// 弹框 Alert - title、message、leftTitle、leftStyle、rightTitle、rightStyle、leftAction、rightAction
fileprivate class JJCSwiftToolsBundles {}
public func JJC_Alert(title: String? = nil,
                      message: String? = nil,
                      leftTitle: String? = nil,
                      leftStyle: UIAlertAction.Style? = .cancel,
                      rightTitle: String? = nil,
                      rightStyle: UIAlertAction.Style? = .default,
                      leftAction: (() -> Void)? = nil,
                      rightAction: (() -> Void)? = nil,
                      lproj: String? = nil) -> UIAlertController {
    var newTitle: String? = nil
    if title != nil && (title ?? "").jjc_isEmptyOrInvalid() {
        newTitle = JJC_Local(byBundle: "Tips", "温馨提示", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
    }
    let alertVC = UIAlertController(title: newTitle, message: message, preferredStyle: .alert)
    if var newLeftTitle = leftTitle {
        if newLeftTitle.jjc_isEmptyOrInvalid() {
            newLeftTitle = JJC_Local(byBundle: "Cancel", "取消", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
        }
        let leftAction = UIAlertAction(title: newLeftTitle, style: leftStyle ?? .cancel) { _ in leftAction?() }
        alertVC.addAction(leftAction)
    }
    if var newRightTitle = rightTitle {
        if newRightTitle.jjc_isEmptyOrInvalid() {
            newRightTitle = JJC_Local(byBundle: "Ensure", "确定", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
        }
        let rightAction = UIAlertAction(title: newRightTitle, style: rightStyle ?? .default) { _ in rightAction?() }
        alertVC.addAction(rightAction)
    }
    return alertVC
}

/// 圆角 - 继承 UIView - view、radius、width、color
public func JJC_RadiusBorder<T: UIView>(_ view: T, radius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor?) {
    if let newRadius = radius {
        view.layer.cornerRadius = newRadius
        view.layer.masksToBounds = true
    }
    if let newBorderWidth = borderWidth {
        view.layer.borderWidth = newBorderWidth
    }
    if let newBorderColor = borderColor {
        view.layer.borderColor = newBorderColor.cgColor
    }
}

/// 圆角 - 继承 CALayer - layer、radius、width、color
public func JJC_RadiusBorder<T: CALayer>(_ layer: T, radius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor?) {
    if let newRadius = radius {
        layer.cornerRadius = newRadius
        layer.masksToBounds = true
    }
    if let newBorderWidth = borderWidth {
        layer.borderWidth = newBorderWidth
    }
    if let newBorderColor = borderColor {
        layer.borderColor = newBorderColor.cgColor
    }
}

/// UUID
public func JJC_UUID() -> String {
    return Bundle.main.bundleIdentifier ?? "" + "_" + UUID().uuidString
}
