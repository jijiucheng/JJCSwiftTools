//
//  JJCDataModelTool.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/3.
//

import UIKit

// MARK:- 数据 转 模型
public class JJCDataModelTool: NSObject {

    /// JJCDataModelTool - 类方法 - 任意类型 转 jsonData   Any -> jsonData
    public static func jsonData(with param: Any) -> Data? {
        // 特殊情况处理
        if param is String {
            guard let data = (param as! String).data(using: .utf8) else { return nil }
            return data
        }
        guard JSONSerialization.isValidJSONObject(param) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else { return nil }
        return data
    }
    
    /// JJCDataModelTool - 类方法 - jsonString 转 模型  jsonString -> model
    public static func decode<T>(_ type: T.Type, jsonString: String) -> T? where T: Decodable {
        guard let jsonData = jsonData(with: jsonString) else { return nil }
        guard let model = try? JSONDecoder().decode(T.self, from: jsonData) else { return nil }
        return model
    }
    
    /// JJCDataModelTool - 类方法 - Any 转 模型    Any -> model
    public static func decode<T>(_ type: T.Type, object: Any) -> T? where T: Decodable {
        guard let jsonData = jsonData(with: object) else { return nil }
        guard let model = try? JSONDecoder().decode(T.self, from: jsonData) else { return nil }
        return model
    }
    
    /// JJCDataModelTool - 类方法 - 字典 转 模型   Dictionary -> model
    public static func decode<T>(_ type: T.Type, dictionary: [String:Any]) -> T? where T: Decodable {
        guard let jsonData = jsonData(with: dictionary) else { return nil }
        guard let model = try? JSONDecoder().decode(T.self, from: jsonData) else { return nil }
        return model
    }
    
    /// JJCDataModelTool - 类方法 - 数组 转 模型   Array<String,Any> -> [model]
    public static func decode<T>(_ type: T.Type, array: [[String:Any]]) -> [T]? where T: Decodable {
        guard let jsonData = jsonData(with: array) else { return nil }
        guard let models = try? JSONDecoder().decode([T].self, from: jsonData) else { return nil }
        return models
    }
}

// MARK:- 模型 转 数据
extension JJCDataModelTool {
    
    /// JJCDataModelTool - 类方法 - 模型 转 jsonData   model -> jsonData
    public static func encodeToData<T>(with model: T) -> Data? where T: Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(model) else { return nil }
        return jsonData
    }
    
    /// JJCDataModelTool - 类方法 - 模型 转 jsonString   model -> jsonString
    public static func encodeToJSONString<T>(with model: T) -> String? where T: Encodable {
        guard let jsonData: Data = encodeToData(with: model) else { return nil }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return nil }
        return jsonString
    }
    
    /// JJCDataModelTool - 类方法 - 模型 转 字典   model -> Dictionary
    public static func encodeToDictionary<T>(with model: T) -> [String:Any]? where T: Encodable {
        guard let jsonData: Data = encodeToData(with: model) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String:Any] else { return nil }
        return dictionary
    }
    
    /// JJCDataModelTool - 类方法 - 模型数组 转 数组   [model] -> Array<String,Any>
    public static func encodeToArray<T>(with model: T) -> [[String:Any]]? where T: Encodable {
        guard let jsonData: Data = encodeToData(with: model) else { return nil }
        guard let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [[String:Any]] else { return nil }
        return array
    }
}

// MARK:- 其他类型转换
extension JJCDataModelTool {
    
    /// JJCDataModelTool - 类方法 - jsonString -> Dictionary
    public static func toDictionaryFromJSONString(_ jsonString: String) -> [String:Any] {
        guard let jsonData: Data = encodeToData(with: jsonString) else { return [String:Any]() }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String:Any] else { return [String:Any]() }
        return dictionary
    }
    
    /// JJCDataModelTool - 类方法 - Any -> jsonString
    public static func toJSONStringFromObject(_ object: Any, encoding: String.Encoding) -> String {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: object, options: []) else { return "" }
        guard let jsonString = String(data: jsonData, encoding: encoding) else { return "" }
        return jsonString
    }
    
    /// JJCDataModelTool - 类方法 - Any -> jsonString<UTF-8>
    public static func toJSONStringFromObject(_ object: Any) -> String {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: object, options: []) else { return "" }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return "" }
        return jsonString
    }
    
    /// JJCDataModelTool - 类方法 - Dictionary -> jsonString
    public static func toJSONStringFromDictionary(_ dictionary: [String:Any], encoding: String.Encoding) -> String {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return "" }
        guard let jsonString = String(data: jsonData, encoding: encoding) else { return "" }
        return jsonString
    }
    
    /// JJCDataModelTool - 类方法 - Dictionary -> jsonString<UTF-8>
    public static func toJSONStringFromDictionary(_ dictionary: [String:Any]) -> String {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return "" }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return "" }
        return jsonString
    }
}
