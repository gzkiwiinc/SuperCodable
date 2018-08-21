//
//  BoolTransformer.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public class BoolTransformer: DecodingContainerTransformer {
    
    public typealias DecodeType = CodableValue
    public typealias TargetType = Bool
    
    public required init() {
    }
    
    public func transform(decoded: CodableValue) throws -> Bool {
        switch decoded {
        case .bool(let boolValue):
            return boolValue
        case .integer(let integer):
            if let int64 = integer.int64 {
                return int64 > 0
            } else if let uint64 = integer.uint64 {
                return uint64 > 0
            } else {
                assertionFailure("can't get int value")
                return false
            }
        case .string(let stringValue):
            if stringValue == "true" || stringValue == "True" || stringValue == "TRUE" {
                return true
            } else if stringValue == "false" || stringValue == "False" || stringValue == "FALSE" {
                return false
            } else {
                throw SuperCodableError.transformFaild(errorDescription: "\(stringValue) can't parse")
            }
        default:
            throw SuperCodableError.transformFaild(errorDescription: "value can't parse")
        }
    }

}
