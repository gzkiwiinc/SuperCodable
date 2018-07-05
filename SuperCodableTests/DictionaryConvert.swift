//
//  SuperCodableTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import XCTest
@testable import SuperCodable

class DictionaryConvert: XCTestCase {
    
    struct TestModel: Codable {
        let name: String
        let age: Int
    }
    
    func testConvertDictonary() {
        let model = TestModel(name: "kiwi", age: 1)
        let dict = try! model.toJSON()
        XCTAssert((dict["name"] as! String) == "kiwi")
    }

    func testInitFromDictoonary() {
        let dict: [String: Any] = ["name": "kiwi", "age": 1]
        let model = TestModel(JSON: dict)!
        XCTAssert(model.name == "kiwi")
    }
    
    func testOptionalValueFilter() {
        let dict: [String: Any?] = ["1": nil, "2": 2]
        let newDict = dict.compactValues()
        XCTAssert(newDict.count == 1)
    }
}
