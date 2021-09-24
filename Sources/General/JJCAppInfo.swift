//
//  JJCAppInfo.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/21.
//

import UIKit

public class JJCAppInfo: NSObject {

}

// MARK:- 获取 App 相关信息
extension JJCAppInfo {
    
    /// JJCDevice - 获取 App 的唯一识别号 BundleIdentifier【CFBundleIdentifier】
    public static func bundleIdentifier() -> String {
        if let targetString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String {
            return targetString
        }
        return ""
    }
    
    /// JJCDevice - 获取 App 名称【DisplayName】
    public static func displayName() -> String {
        if let targetString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return targetString
        }
        return ""
    }
    
    /// JJCDevice - 获取 App 名称【CFBundleName】
    public static func bundleName() -> String {
        if let targetString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return targetString
        }
        return ""
    }
    
    /// JJCDevice - 获取 App release 版本号【CFBundleShortVersionString】
    public static func releaseVersion() -> String {
        if let targetString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return targetString
        }
        return ""
    }
    
    /// JJCDevice - 获取 App debug 版本号【CFBundleVersion】
    public static func debugVersion() -> String {
        if let targetString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            return targetString
        }
        return ""
    }
    
    /// JJCDevice - 获取 App 版本号（releaseVersion + debugVersion）【CFBundleShortVersionString + CFBundleVersion】
    public static func fullVersion() -> String {
        return "\(JJCAppInfo.releaseVersion())(\(JJCAppInfo.debugVersion()))"
    }
    
    /// JJCDevice - 获取 App 版本号信息
    public static func version() -> (release: String, debug: String, full: String) {
        return (JJCAppInfo.releaseVersion(),
                JJCAppInfo.debugVersion(),
                JJCAppInfo.fullVersion())
    }
}

