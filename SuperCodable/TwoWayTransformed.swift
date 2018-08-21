//
//  TwoWayTransformed.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/17.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public struct TwoWayTransformed<T: CodingContainerTransformer>: Codable where T.DecodeType: Codable, T.EncodeType: Encodable {
    public var input: T.DecodeType?
    public var target: T.TargetType?
    
    public init(input: T.DecodeType) {
        self.input = input
    }
    
    public init(target: T.TargetType) {
        self.target = target
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        target = try container.decode(transformer: T())
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let target = target {
            let transformedInput = try T().transform(target: target)
            try container.encode(transformedInput)
        } else {
            try container.encodeNil()
        }
    }
}
