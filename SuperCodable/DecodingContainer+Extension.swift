//
//  Codable+Transform.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public extension KeyedDecodingContainer {
    public func decode<Transformer: DecodingContainerTransformer>(_ key: KeyedDecodingContainer.Key,
                                                                  transformer: Transformer) throws -> Transformer.TargetType where Transformer.DecodeType: Decodable {
        let decodedValue: Transformer.DecodeType = try self.decode(key)
        
        return try transformer.transform(decoded: decodedValue)
    }
    
    public func decode<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    public func decode<T: Decodable>(forKey key: Key,
                                     default defaultExpression: @autoclosure () -> T) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}

public extension SingleValueDecodingContainer {
    public func decode<Transformer: DecodingContainerTransformer>(transformer: Transformer) throws -> Transformer.TargetType where Transformer.DecodeType: Decodable {
        let decoded: Transformer.DecodeType = try self.decode()
        return try transformer.transform(decoded: decoded)
    }
    
    public func decode<T: Decodable>() throws -> T {
        return try self.decode(T.self)
    }
}

public extension KeyedEncodingContainer {
    
    public mutating func encode<Transformer: EncodingContainerTransformer>(_ value: Transformer.TargetType,
                                                                           forKey key: KeyedEncodingContainer.Key,
                                                                           transformer: Transformer) throws where Transformer.EncodeType: Encodable {
        let transformed: Transformer.EncodeType = try transformer.transform(target: value)
        try self.encode(transformed, forKey: key)
    }
}

public extension UnkeyedEncodingContainer {
    public mutating func encode<Transformer: EncodingContainerTransformer>(_ value: Transformer.TargetType,
                                                                           transformer: Transformer) throws where Transformer.EncodeType: Encodable {
        let transformed: Transformer.EncodeType = try transformer.transform(target: value)
        try self.encode(transformed)
    }
}
