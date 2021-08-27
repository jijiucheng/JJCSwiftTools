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
/// JJCSwiftToolsBundle 的设计原因是 Bundle 的 public init(for aClass: AnyClass) 方法，根据某个类获取当前工程下的主 Bundle，如果不进行如此操作，获取的就是 Demo 工程里的 Main Bundle
/// 参考链接：https://www.jianshu.com/p/b64ff9d8e7ce、https://www.jianshu.com/p/173076faa742
fileprivate class JJCSwiftToolsBundle {}
public func JJC_Local_private(_ key: String, _ comment: String? = nil, bundle: String) -> String {
    let bundlePath = Bundle(for: JJCSwiftToolsBundle.self).path(forResource: bundle, ofType: "bundle") ?? ""
    if let mainBundle = Bundle(path: bundlePath) {
        return JJC_Local(key, comment, bundle: mainBundle)
    }
    return ""
}

/// 本地语言 - 带注释（Bundle 文件）
public func JJC_LocalBundle_private(_ key: String, _ comment: String? = nil) -> String {
    return JJC_Local_private(key, comment, bundle: "JJCSwiftTools")
}
