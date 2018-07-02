//
//  Dictionary+Helper.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/7/1.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public protocol OptionalType {
    associatedtype Wrapped
    var asOptional : Wrapped? { get }
}

extension Optional: OptionalType {
    public var asOptional : Wrapped? {
        return self
    }
}

public extension Dictionary where Value: OptionalType {
    
    // TODO: refracotr on Swift 4.2
    /// Removes nil values entirely. Makes optionals non-optional
    public func compactValues() -> [Key: Value.Wrapped] {
        var newDict: [Key: Value.Wrapped] = [:]
        for (key, value) in self {
            if let v = value.asOptional {
                newDict.updateValue(v, forKey: key)
            }
        }
        return newDict
    }
}
