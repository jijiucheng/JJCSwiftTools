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
public let JJC_BundleIdentifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
/// JJCAPI - 系统信息 - App 名称
public let JJC_BundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
/// JJCAPI - 系统信息 - release version
public let JJC_ReleaseVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
/// JJCAPI - 系统信息 - debug version
public let JJC_DebugVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
/// JJCAPI - 系统信息 - releaseVersion + debugVersion）【CFBundleShortVersionString + CFBundleVersion】
public let JJC_FullVersion = "\(JJC_ReleaseVersion)(\(JJC_DebugVersion))"


// MARK:- 全局函数

/// JJCAPI - 系统信息 - 版本 version 信息
public func JJC_Version() -> (release: String, debug: String, full: String) {
    return (JJC_ReleaseVersion, JJC_DebugVersion, JJC_FullVersion)
}

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

/// JJJCAPI - 本地语言 - 获取当前手机系统语言【设置->通用->语言->首选语言顺序】
/// - 此处也可以通过 UserDefaults.standard.value(forKey: "AppleLanguages") 获取
public func JJC_systemLanguage() -> String {
    return JJCLocal.jjc_systemLanguage()
}

/// JJCAPI - 本地语言 - 获取当前语言环境（根据 Bundle 获取 lproj 的语言文件）
public func JJC_Language(_ bundle: Bundle = Bundle.main) -> String {
    return JJCLocal.jjc_language(bundle)
}

/// JJCAPI - 本地语言 - 带注释（根据 Bundle 获取 lproj 的语言文件）
public func JJC_Local(_ key: String, _ comment: String? = nil, bundle: Bundle = Bundle.main, lproj: String? = nil) -> String {
    return JJCLocal.jjc_local(key, comment, bundle: bundle, lproj: lproj)
}

/// JJCAPI - 弹框 Alert - title、message、leftTitle、leftStyle、rightTitle、rightStyle、leftAction、rightAction
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
        newTitle = JJCLocal.jjc_local(byBundle: "Tips", "温馨提示", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
    }
    let alertVC = UIAlertController(title: newTitle, message: message, preferredStyle: .alert)
    if var newLeftTitle = leftTitle {
        if newLeftTitle.jjc_isEmptyOrInvalid() {
            newLeftTitle = JJCLocal.jjc_local(byBundle: "Cancel", "取消", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
        }
        let leftAction = UIAlertAction(title: newLeftTitle, style: leftStyle ?? .cancel) { _ in leftAction?() }
        alertVC.addAction(leftAction)
    }
    if var newRightTitle = rightTitle {
        if newRightTitle.jjc_isEmptyOrInvalid() {
            newRightTitle = JJCLocal.jjc_local(byBundle: "Ensure", "确定", bundleName: "JJCSwiftTools", objClass: JJCSwiftToolsBundles.self, lproj: lproj)
        }
        let rightAction = UIAlertAction(title: newRightTitle, style: rightStyle ?? .default) { _ in rightAction?() }
        alertVC.addAction(rightAction)
    }
    return alertVC
}

/// JJCAPI - 圆角 - 继承 UIView - view、radius、width、color
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

/// JJCAPI - 圆角 - 继承 CALayer - layer、radius、width、color
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

/// JJCAPI - 通知 Name
public func JJC_NotiName(_ name: String) -> Notification.Name {
    return Notification.Name(rawValue: name)
}

/// UUID
public func JJC_UUID() -> String {
    return Bundle.main.bundleIdentifier ?? "" + "_" + UUID().uuidString
}

/// 获取当前控制器视图 UIViewController
public func JJC_CurViewController() -> UIViewController {
    // 定义一个变量存放当前屏幕显示的 viewController
    var currentVC = UIViewController()
    // 得到当前应用程序的主窗口（需要在 viewDidLoad 加载完成才会有值）
    var keyWindow = UIApplication.shared.windows[0]
    
    // windowLevel 是在 Z轴方向上的窗口位置，默认值是 UIWindowLevel
    if keyWindow.windowLevel != UIWindow.Level.normal {
        // 获取应用程序的所有窗口并进行遍历
        for window in UIApplication.shared.windows {
            // 找到程序的默认窗口（正在显示的窗口）
            if window.windowLevel == UIWindow.Level.normal {
                // 将关键窗口赋值为默认窗口
                keyWindow = window
                break
            }
        }
    }
    
    // 根据获取到的主窗口获取当前根控制器，并判断是否存在
    if let rootVC = keyWindow.rootViewController {
        // 获取窗口的当前显示图，并判断是否存在
        if let frontView = keyWindow.subviews.first {
            // 获取视图的下一个响应者，UIView 视图调用这个方法的返回值为 UIViewController 或它的父视图
            var nextResponder = frontView.next
            
            // 判断显示视图的下一个响应者是否为一个 UITabBarController 的类对象
            if rootVC.isKind(of: UITabBarController.self) {
                nextResponder = rootVC
            }
            // 判断显示视图的下一个响应者是否为一个 UIViewController 的类对象
            if var presetedVC = rootVC.presentedViewController {
                while (presetedVC.presentedViewController != nil) {
                    presetedVC = presetedVC.presentedViewController!
                }
                nextResponder = presetedVC
            }
            
            if (nextResponder?.isKind(of: UITabBarController.self)) ?? false {
                let tabBarVC = nextResponder as! UITabBarController
                if let viewControllers = tabBarVC.viewControllers {
                    let naviVC = viewControllers[tabBarVC.selectedIndex]
                    if let lastVC = naviVC.children.last {
                        currentVC = lastVC
                    }
                }
            } else if (nextResponder?.isKind(of: UINavigationController.self)) ?? false {
                let naviVC = nextResponder as! UINavigationController
                if let lastVC = naviVC.children.last {
                    currentVC = lastVC
                }
            } else {
                if (nextResponder?.isKind(of: UIView.self)) ?? false {
                    
                } else {
                    currentVC = nextResponder as! UIViewController
                }
            }
        }
    }
    return currentVC
}
