//
//  JJCImageTitleModel.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/3.
//

import UIKit
import Foundation

// MARK:- 图片文字模型
public struct JJCImageTitleModel {
    /// 图片
    public var image: UIImage? = nil
    /// 选中图片
    public var selectImage: UIImage? = nil
    /// 主标题
    public var title: String = ""
    /// 选中标题
    public var selectTitle: String = ""
    /// 副标题
    public var subTitle: String = ""
    /// 选中副标题
    public var selectSubTitle: String = ""
    /// 是否选中
    public var isSelected: Bool = false
    
    public init() {}
}
