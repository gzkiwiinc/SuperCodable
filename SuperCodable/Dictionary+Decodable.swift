//
//  Dictionary+Decodable.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/7/5.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

extension Dictionary where Element == (key: String, value: DecodableValue) {
    
    /// The Key paramater can be a period separated string (ex. "distance.value") to access sub objects.
    public func valueFor(key: String) -> DecodableValue? {
        let wrap = DecodableValue.dictionary(self)
        return wrap[key]
    }
}