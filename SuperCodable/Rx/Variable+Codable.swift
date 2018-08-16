//
//  Variable+Codable.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/8/16.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation
import RxSwift

public protocol DecodeFailable {
    static var decodeFailedValue: Self { get }
}

extension Optional: DecodeFailable {
    public static var decodeFailedValue: Optional<Wrapped> {
        return nil
    }
}

extension Variable: Decodable where Element: Decodable & DecodeFailable {
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(Element.self)
            self.init(value)
        } catch {
            self.init(Element.decodeFailedValue)
        }
    }

}

extension Variable: Encodable where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
