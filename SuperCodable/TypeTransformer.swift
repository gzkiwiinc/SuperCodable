//
//  TransformType.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol DecodingContainerTransformer {
    associatedtype Input
    associatedtype DecodableType
    func transform(_ decoded: Input) throws -> DecodableType
}

public protocol EncodingContainerTransformer {
    associatedtype Input
    associatedtype DecodableType
    func transform(_ encoded: DecodableType) throws -> Input
}

public typealias CodingContainerTransformer = DecodingContainerTransformer & EncodingContainerTransformer
