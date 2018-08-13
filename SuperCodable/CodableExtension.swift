//
//  CodableExtension.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/13.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder {}
extension PropertyListDecoder: AnyDecoder {}

public protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder {}
extension PropertyListEncoder: AnyEncoder {}

extension Data {
    public func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}

extension Encodable {
    public func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
