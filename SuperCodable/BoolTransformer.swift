//
//  BoolTransformer.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public class BoolTransformer: DecodingContainerTransformer {
    
    public typealias Input = DecodableValue
    public typealias DecodableType = Bool
    
    public func transform(_ decoded: DecodableValue) throws -> Bool {
        switch decoded {
        case .bool(let boolValue):
            return boolValue
        case .int(let intValue):
            return intValue > 0
        case .int64(let intValue):
            return intValue > 0
        case .uint(let intValue):
            return intValue > 0
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
