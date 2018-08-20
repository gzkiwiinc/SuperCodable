//
//  TransformType.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol DecodingContainerTransformer {
    associatedtype Input: Decodable
    associatedtype TargetType
    
    init()

    func transform(_ decoded: Input) throws -> TargetType
}

public protocol EncodingContainerTransformer {
    associatedtype Input: Encodable
    associatedtype TargetType
    
    init()

    func transform(target: TargetType) throws -> Input
}

public typealias CodingContainerTransformer = DecodingContainerTransformer & EncodingContainerTransformer
