//
//  JSONValue+Value.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

extension CodableValue {
    
    public var intValue: Int? {
        if case .integer(let integer) = self {
            return integer.int
        } else {
            return nil
        }
    }
    
    public var int64Value: Int64? {
        if case .integer(let integer) = self {
            return integer.int64
        } else {
            return nil
        }
    }
    
    public var uintValue: UInt? {
        if case .integer(let integer) = self {
            return integer.uint
        } else {
            return nil
        }
    }
    
    public var uint64Value: UInt64? {
        if case .integer(let integer) = self {
            return integer.uint64
        } else {
            return nil
        }
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
        case .integer(let integer):
            return integer
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
