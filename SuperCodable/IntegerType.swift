//
//  IntegerType.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/7.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol IntegerType: Decodable {
    var int: Int? { get }
    var int64: Int64? { get }
    var uint: UInt? { get }
    var uint64: UInt64? { get }
}

extension Int: IntegerType {
    public var int: Int? {
        return self
    }
    
    public var int64: Int64? {
        return Int64(exactly: self)
    }
    
    public var uint: UInt? {
        return UInt(exactly: self)
    }
    
    public var uint64: UInt64? {
        return UInt64(exactly: self)
    }
}

extension Int64: IntegerType {
    public var int: Int? {
        return Int(exactly: self)
    }
    
    public var int64: Int64? {
        return self
    }
    
    public var uint: UInt? {
        return UInt(exactly: self)
    }
    
    public var uint64: UInt64? {
        return UInt64(exactly: self)
    }
}

extension UInt: IntegerType {
    public var int: Int? {
        return Int(exactly: self)
    }
    
    public var int64: Int64? {
        return Int64(exactly: self)
    }
    
    public var uint: UInt? {
        return self
    }
    
    public var uint64: UInt64? {
        return UInt64(exactly: self)
    }
}

extension UInt64: IntegerType {
    public var int: Int? {
        return Int(exactly: self)
    }
    
    public var int64: Int64? {
        return Int64(exactly: self)
    }
    
    public var uint: UInt? {
        return UInt(exactly: self)
    }
    
    public var uint64: UInt64? {
        return self
    }
}
