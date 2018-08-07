//
//  Integer+Codable.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/7.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

extension SingleValueEncodingContainer {
    
    public mutating func encode(_ value: IntegerType) throws {
        if let int64 = value.int64 {
            try encode(int64)
        } else if let uint64 = value.uint64 {
            try encode(uint64)
        } else {
            assertionFailure("unexpected integer")
        }
    }
}
