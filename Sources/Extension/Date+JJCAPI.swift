//
//  Date+JJCAPI.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/11/25.
//

import Foundation


// MARK:- 月份转换格式信息
public struct JJCMonthInfo {
    var num: String = ""        // 数字样式
    var enAll: String = ""      // 英文全称
    var en: String = ""         // 英文简称
    var cn: String = ""         // 中文样式
}

// MARK:- 时间信息
public struct JJCTimeInfo {
    var origin: String = ""         // 原始样式时间，未处理时区
    var timestamp: Double = 0       // 时间戳（秒级）
    var format: String = ""         // 格式化时间样式时间
    var year: String = ""           // 年
    var month = JJCMonthInfo()      // 月
    var day: String = ""            // 日
    var hour: String = ""           // 时
    var minute: String = ""         // 分
    var second: String = ""         // 秒
}


// MARK:- Date 获取时间相关
extension Date {
    
    /// Date - 类方法 - 获取时间格式化对象 DateFormatter（默认：yyyy-MM-dd HH:mm:ss）
    public static func jjc_dateFormatter(_ dateFormat: String? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter()
        if let newDateFormat = dateFormat {
            dateFormatter.dateFormat = newDateFormat
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        return dateFormatter
    }
    
    /// Date - 类方法 - 获取当前时间（默认：yyyy-MM-dd HH:mm:ss）
    public static func jjc_curTimeString(_ dateFormat: String? = nil) -> String {
        var targetString = ""
        let dateFormatter = Date.jjc_dateFormatter(dateFormat)
        targetString = dateFormatter.string(from: Date())
        return targetString
    }
    
    /// Date - 类方法 - 获取当前时间信息
    /// - dateFormat：格式化样式
    public static func jjc_curTime(_ dateFormat: String? = nil) -> JJCTimeInfo {
        var timeInfo = JJCTimeInfo()
        timeInfo.origin = "\(Date())"
        timeInfo.timestamp = Date().timeIntervalSince1970
        timeInfo.format = Date.jjc_curTimeString(dateFormat)
        let formatString = Date.jjc_curTimeString()
        timeInfo.year = formatString.jjc_subRange(0, 3)
        timeInfo.month = Date.jjc_toMonth(formatString.jjc_subRange(5, 6))
        timeInfo.day = formatString.jjc_subRange(8, 9)
        timeInfo.hour = formatString.jjc_subRange(11, 12)
        timeInfo.minute = formatString.jjc_subRange(14, 15)
        timeInfo.second = formatString.jjc_subRange(17, 18)
        return timeInfo
    }
}

// MARK:- Date 时间转换
extension Date {
    
    /// Date - 类方法 - 时间戳转时间字符串
    /// - timestamp：秒级
    /// - dateFormat：格式化样式（默认：yyyy-MM-dd HH:mm:ss）
    public static func jjc_toTimeString(_ timestamp: Double, _ dateFormat: String? = nil) -> String {
        var targetString = ""
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = Date.jjc_dateFormatter(dateFormat)
        targetString = dateFormatter.string(from: date)
        return targetString
    }
    
    /// Date - 实例方法 - 日期转时间字符串
    /// - dateFormat：格式化样式（默认：yyyy-MM-dd HH:mm:ss）
    public func jjc_toTimeString(_ dateFormat: String? = nil) -> String {
        var targetString = ""
        let dateFormatter = Date.jjc_dateFormatter(dateFormat)
        targetString = dateFormatter.string(from: self)
        return targetString
    }
    
    /// Date - 实例方法 - 日期转时间戳
    public func jjc_toTimestamp() -> Double {
        return self.timeIntervalSince1970
    }
    
    /// Date - 类方法 - 月历转数字（英文全、英文简、中文、数字）
    public static func jjc_toMonth(_ month: String) -> JJCMonthInfo {
        var monthInfo = JJCMonthInfo()
        let enAllMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let enMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let cnMonths = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        let numMonths = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        for (index, _) in enAllMonths.enumerated() {
            if month == enAllMonths[index] || month == enMonths[index] || month == cnMonths[index] || Int(month) == Int(numMonths[index]) {
                monthInfo.enAll = enAllMonths[index]
                monthInfo.en = enMonths[index]
                monthInfo.cn = cnMonths[index]
                monthInfo.num = numMonths[index]
                break
            }
        }
        return monthInfo
    }
}
