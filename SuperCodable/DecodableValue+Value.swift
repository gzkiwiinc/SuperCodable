//
//  JSONValue+Value.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

extension DecodableValue {
    
    public var intValue: Int? {
        return value as? Int
    }
    
    public var int64Value: Int64? {
        return value as? Int64
    }
    
    public var uintValue: UInt? {
        return value as? UInt
    }
    
    public var doubleValue: Double? {
        return value as? Double
    }
    
    public var stringValue: String? {
        return value as? String
    }
    
    public var boolValue: Bool? {
        return value as? Bool
    }
    
    public var value: Any? {
        switch self {
        case .null:
            return nil
        case .bool(let boolValue):
            return boolValue
        case .string(let stringValue):
            return stringValue
        case .int(let intValue):
            return intValue
        case .int64(let int64Value):
            return int64Value
        case .uint(let uintValue):
            return uintValue
        case .double(let doubleValue):
            return doubleValue
        case .array(let arrayValue):
            return arrayValue.map { $0.value }
        case .dictionary(let dictValue):
            return dictValue.mapValues { return $0.value }
        }
    }
    
    public var compactArray: [Any]? {
        guard let rawArray = value as? [Any?] else { return  nil }
        return rawArray.compactMap { $0 }
    }
    
    public var compactDictionary: [String: Any]? {
        guard let rawDict = value as? [String: Any?] else { return  nil }
        return rawDict.compactValues()
    }
}
