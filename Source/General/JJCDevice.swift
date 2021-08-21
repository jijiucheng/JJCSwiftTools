//
//  JJCDevice.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/21.
//

import UIKit
import AppTrackingTransparency
import AdSupport

public class JJCDevice: NSObject {

}

// MARK:- 获取系统属性
extension JJCDevice {
    
    /// JJCDevice - 获取设备号 ID【通过访问 IDFA 获取】
    public static func deviceID() -> String {
        var targetString = ""
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                if status == .authorized {
                    targetString = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                }
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                targetString = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            }
        }
        return targetString
    }
    
    /// JJCDevice - 获取系统版本号
    public static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// JJCDevice - 获取系统名称
    public static func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    /// JJCDevice - 获取设备名称（自定义）
    public static func name() -> String {
        return UIDevice.current.name
    }
}

// MARK:- 获取设备类型
extension JJCDevice {
    
    /// JJCDevice - 判断是否为 iPhone
    public static func isIPone() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .phone)
    }
    
    /// JJCDevice - 判断是否为 iPad
    public static func isIPad() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .pad)
    }
    
    /// JJCDevice - 判断是否为 CarPlay
    public static func isCarPlay() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .carPlay)
    }
    
    /// JJCDevice - 判断是否为 mac
    public static func isMac() -> Bool {
        if #available(iOS 14.0, *) {
            return (UIDevice.current.userInterfaceIdiom == .mac)
        } else {
            return false
        }
    }
    
    /// JJCDevice - 判断是否为 tv
    public static func isTV() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .tv)
    }
    
    /// 是否是刘海屏
    public func isIPhoneX() -> Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
        } else {
            return false
        }
    }
}

