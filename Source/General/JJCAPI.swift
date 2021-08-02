//
//  JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/7/29.
//

import Foundation
import UIKit

// MARK:- 全局常量

/// 屏幕尺寸
public let JJC_ScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
/// 屏幕宽度
public let JJC_ScreenW = JJC_ScreenSize.width
/// 屏幕高度
public let JJC_ScreenH = JJC_ScreenSize.height
/// 导航栏高度
public let JJC_NaviH: CGFloat = 44.0
/// KeyWindow
public let JJC_KeyWindow: UIWindow = UIApplication.shared.windows[0]

/// 基础间隙
public let JJC_Margin: CGFloat = 10

/// 沙盒 Document 路径
public let JJC_DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
/// 沙盒 Cache 路径
public let JJC_CachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
/// 沙盒 temp 路径
public let JJC_TempPath = NSTemporaryDirectory()

/// 当前语言（"en-CN"、"zh-Hans"、...）
public let JJC_CurLanguage = Locale.preferredLanguages.first!
/// 是否为 iPhone
public let JJC_IsIPhone = (UIDevice.current.userInterfaceIdiom == .phone)
/// 是否为 iPad
public let JJC_IsIPad = (UIDevice.current.userInterfaceIdiom == .pad)
/// 是否为 CarPlay
public let JJC_IsCarPlay = (UIDevice.current.userInterfaceIdiom == .carPlay)

/// 系统信息 - App 名称
public let JJC_BundleIdentifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
/// 系统信息 - App 名称
public let JJC_BundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
/// 系统信息 - release version
public let JJC_ReleaseVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
/// 系统信息 - debug version
public let JJC_DebugVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
/// 系统信息
public let JJC_Version = "\(JJC_ReleaseVersion)(\(JJC_DebugVersion))"


// MARK:- 全局函数

/// 是否是刘海屏
public func JJC_IsIPhoneX() -> Bool {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
    } else {
        return false
    }
}

/// 状态栏高度
public func JJC_StatusH() -> CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/// （状态栏+导航栏）高度
public func JJC_StatusNaviH() -> CGFloat {
    if #available(iOS 13.0, *) {
        return (UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + JJC_NaviH
    } else {
        return UIApplication.shared.statusBarFrame.height + JJC_NaviH
    }
}

/// 底部 TabBar 高度
public func JJC_TabBarH() -> CGFloat {
    return JJC_IsIPhoneX() ? (49.0 + 34.0) : 49.0
}

/// 生成随机数
public func JJC_Random(min: Int, max: Int) -> Int {
    return Int.random(in: min...max)
}

/// 颜色 - RGBA
public func JJC_RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(red: r, green: g, blue: b, alpha: a ?? 1.0)
}

/// 颜色 - RGBA_255
public func JJC_RGBA_255(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255, blue: b / 255, alpha: a ?? 1.0)
}

/// 颜色 - HexColorA
public func JJC_HexColorA(_ hexString: String, _ a: CGFloat? = 1.0) -> UIColor {
    return UIColor(hexString: hexString, alpha: a ?? 1.0)
}

/// 本地语言 - 带注释
public func JJC_Local(_ key: String, _ comment: String? = nil) -> String {
    return NSLocalizedString(key, comment: comment ?? "")
}

/// 当前语言环境
public func JJC_Language() -> String {
    return Bundle.main.preferredLocalizations.first ?? "en"
}

/// 获取当前所有语言环境
public func JJC_Languages() -> [String] {
    return Bundle.main.localizations
}

/// 当前语言环境是否是中文
public func JJC_IsChinese() -> (Bool, String) {
    let preferredLang = Bundle.main.preferredLocalizations.first ?? ""
    switch String(describing: preferredLang) {
    case "en-US", "en-CN":
        return (false, preferredLang)
    case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
        return (true, preferredLang)
    default:
        return (false, preferredLang)
    }
}

/// 弹框 Alert - title、message、leftTitle、leftStyle、rightTitle、rightStyle、leftAction、rightAction
public func JJC_Alert(title: String? = nil,
                      message: String? = nil,
                      leftTitle: String? = nil,
                      leftStyle: UIAlertAction.Style? = .cancel,
                      rightTitle: String? = nil,
                      rightStyle: UIAlertAction.Style? = .default,
                      leftAction: (() -> Void)? = nil,
                      rightAction: (() -> Void)? = nil) -> UIAlertController {

    var newTitle: String? = nil
    if title != nil && (title ?? "").jjc_isEmptyOrInvalid() {
        newTitle = JJC_LocalBundle_private("Tips", "温馨提示")
    }
    let alertVC = UIAlertController(title: newTitle, message: message, preferredStyle: .alert)
    if var newLeftTitle = leftTitle {
        if newLeftTitle.jjc_isEmptyOrInvalid() {
            newLeftTitle = JJC_LocalBundle_private("Cancel", "取消")
        }
        let leftAction = UIAlertAction(title: newLeftTitle, style: leftStyle ?? .cancel) { _ in leftAction?() }
        alertVC.addAction(leftAction)
    }
    if var newRightTitle = rightTitle {
        if newRightTitle.jjc_isEmptyOrInvalid() {
            newRightTitle = JJC_LocalBundle_private("Ensure", "确定")
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
