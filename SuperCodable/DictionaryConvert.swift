//
//  EncodableExtensions.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

extension Encodable {
    
    /// Returns the JSON Dictionary for the object
    public func toJSON() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
    
    /// Returns the JSON Dictionary for the object. if error happend return nil
    public func toJSONSafely() -> [String: Any]? {
        return try? self.toJSON()
    }
    
    /// if parse error, return empty string
    public func toJSONStringSafely(prettyPrint: Bool = false) -> String? {
        do {
            return try toJSONString(prettyPrint: prettyPrint)
        } catch  {
            return nil
        }
    }
    
    public func toJSONString(prettyPrint: Bool = false) throws -> String? {
        let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
        let json = try toJSON()
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: options)
        return String(data: jsonData, encoding: String.Encoding.utf8)
    }
}

extension Decodable {
    
    /// Initializes object from a JSON Dictionary
    public init?(JSON: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: JSON, options: [])
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    public init?(JSONString: String, prettyPrint: Bool = false) {
        guard let data = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: true) else { return nil }
        do {
            let JSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
            let jsonData = try JSONSerialization.data(withJSONObject: JSON, options: options)
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }

    }

}
