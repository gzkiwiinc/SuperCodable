//
//  JSONValue.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public enum DecodableValue: Decodable {
    indirect case dictionary([String: DecodableValue])
    indirect case array([DecodableValue])
    case null
    case bool(Bool)
    case string(String)
    case int(Int64)
    case uint(UInt)
    case double(Double)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .null
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let int = try? container.decode(Int64.self) {
            self = .int(int)
        } else if let uint = try? container.decode(UInt.self) {
            self = .uint(uint)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let array = try? container.decode([DecodableValue].self) {
            self = .array(array)
        } else if let dictionary = try? container.decode([String: DecodableValue].self) {
            self = .dictionary(dictionary)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "value cannot be decoded")
        }
    }
}


