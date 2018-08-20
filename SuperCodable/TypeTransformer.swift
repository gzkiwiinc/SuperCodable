//
//  TransformType.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol DecodingContainerTransformer {
    associatedtype DecodeType
    associatedtype TargetType
    
    init()

    func transform(decoded: DecodeType) throws -> TargetType
}

public protocol EncodingContainerTransformer {
    associatedtype EncodeType
    associatedtype TargetType
    
    init()

    func transform(target: TargetType) throws -> EncodeType
}

public typealias CodingContainerTransformer = DecodingContainerTransformer & EncodingContainerTransformer
