//
//  Decodable+Transform.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public struct TransformedValue<T: DecodingContainerTransformer>: Decodable {
    public let rawValue: DecodableValue
    public let value: T.TargetType
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(DecodableValue.self)
        if let input = rawValue as? T.Input { // Input is Decoable
            value = try T().transform(input)
        } else if let input = rawValue.value as? T.Input {
            value = try T().transform(input)
        } else {
            throw SuperCodableError.transformFaild(errorDescription: "input value don't match Transformer input type")
        }
    }

}
