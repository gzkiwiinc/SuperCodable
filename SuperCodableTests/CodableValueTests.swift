//
//  JSONValueTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import XCTest
@testable import SuperCodable

class JSONValueTests: XCTestCase {
    
    let json = """
{
    "code": 1,
    "data": {
        "user": {
            "userId": 331061676730122,
            "username": "富贵",
            "completed": true
        }
    }
}
""".data(using: .utf8)!
    
    struct ServerResponse: Decodable {
        let code: Int
        let data: [String: CodableValue]
    }
    
    func testAnyDcitionaryParse() {
        let decoder = JSONDecoder()
        let response = try! decoder.decode(ServerResponse.self, from: json)
        let userData = response.data["user"]!
        guard case CodableValue.dictionary(let dict) = userData else {
            XCTFail()
            return
        }
        XCTAssert(dict["userId"]!.intValue == 331061676730122)
    }
    
    func testEncode() {
        let decoder = JSONDecoder()
        let response = try! decoder.decode(ServerResponse.self, from: json)
        XCTAssert(response.data.toJSONStringSafely()! == """
            {"user":{"completed":true,"userId":331061676730122,"username":"富贵"}}
            """)
        
        let array = CodableValue.array([.integer(1),.integer(2)])
        let dict = CodableValue.dictionary(["custom": array])
        XCTAssert(dict.toJSONStringSafely()! == """
            {"custom":[1,2]}
            """)
    }

    func testGetReuglarValue() {
        let bool = CodableValue.bool(true)
        XCTAssert(bool.boolValue! == true)
        
        let string = CodableValue.string("kiwi")
        XCTAssert(string.stringValue! == "kiwi")
        
        let int = CodableValue.integer(100)
        XCTAssert(int.intValue! == 100)
        
        let uint = CodableValue.integer(10)
        XCTAssert(uint.uintValue! == 10)
        
        let double = CodableValue.double(1.01)
        XCTAssert(double.doubleValue! == 1.01)
        
        let nilValue = CodableValue.null
        XCTAssert(nilValue.value == nil)
    }
    
    func testGetCompactArray() {
        let arrayJson = """
[
          {
            "lat" : 30.523707112805059,
            "lng" : 119.9777285274059
          },
          {
            "lat" : 30.522707812333241,
            "lng" : 119.9781851450592
          },null,
          {
            "lat" : 30.523057167744138,
            "lng" : 119.97921547415039
          },
          {
            "lat" : 30.524056464623509,
            "lng" : 119.97875885647299
          }
]
""".data(using: .utf8)!
        let decoder = JSONDecoder()
        let value = try! decoder.decode(CodableValue.self, from: arrayJson)
        XCTAssert(value.compactArray!.count == 4)
    }
    
    func testGetCompactDictionary() {
        let dictJson = """
{
    "lat" : 30.524156276338669,
    "unknown": null,
    "lng" : 119.9787132472559
}
""".data(using: .utf8)!
        let decoder = JSONDecoder()
        let value = try! decoder.decode(CodableValue.self, from: dictJson)
        let dict = value.compactDictionary!
        XCTAssert(dict.count == 2)
    }
    
    func testSubscript() {
        let singleDict: [String: CodableValue] = ["name": CodableValue.string("kyle")]
        let signleDecodable = CodableValue.dictionary(singleDict)
        XCTAssert(signleDecodable["name"]!.stringValue! == "kyle")
        let nestData = CodableValue.dictionary(["data": signleDecodable])
        XCTAssert(nestData["data.name"]!.stringValue! == "kyle")
    }
    
    func testKeypathInDictionary() {
        let singleDict: [String: CodableValue] = ["name": CodableValue.string("kyle")]
        let signleDecodable = CodableValue.dictionary(singleDict)
        let nestData: [String: CodableValue] = ["data": signleDecodable]
        XCTAssert(nestData.valueFor(key: "data.name")!.stringValue! == "kyle")
    }
    
}
