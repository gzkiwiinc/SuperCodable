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
                                                                  transformer: Transformer) throws -> Transformer.TargetType where Transformer.Input: Decodable {
        let decoded: Transformer.Input = try self.decode(key)
        
        return try transformer.transform(decoded)
    }
    
    public func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try self.decode(T.self, forKey: key)
    }
}

public extension KeyedEncodingContainer {
    
    public mutating func encode<Transformer: EncodingContainerTransformer>(_ value: Transformer.TargetType,
                                                                           forKey key: KeyedEncodingContainer.Key,
                                                                           transformer: Transformer) throws where Transformer.Input : Encodable {
        let transformed: Transformer.Input = try transformer.transform(value)
        try self.encode(transformed, forKey: key)
    }
}
