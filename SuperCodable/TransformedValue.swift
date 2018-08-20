//
//  Decodable+Transform.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public struct TransformedValue<T: DecodingContainerTransformer>: Codable {
    public let rawValue: CodableValue
    public let value: T.TargetType
    
    public init(rawValue: CodableValue) throws {
        self.rawValue = rawValue
        if let input = rawValue.value as? T.DecodeType {
            value = try T().transform(decoded: input)
        } else {
            throw SuperCodableError.transformFaild(errorDescription: "input value don't match Transformer input type")
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(CodableValue.self)
        if let input = rawValue as? T.DecodeType { // DecodeType is Decoable
            value = try T().transform(decoded: input)
        } else if let input = rawValue.value as? T.DecodeType {
            value = try T().transform(decoded: input)
        } else {
            throw SuperCodableError.transformFaild(errorDescription: "input value don't match Transformer input type")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
