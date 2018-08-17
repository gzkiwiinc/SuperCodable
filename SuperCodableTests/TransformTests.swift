//
//  TransformTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/8/3.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import XCTest
@testable import SuperCodable

class TransformTests: XCTestCase {
    
    private let testStringDictionary = ["isValid": "true"]

    func testBoolTransformer() {
        var testBool = try! TestBool(JSON: testStringDictionary)
        XCTAssert(testBool.isValid == true)
        
        let testIntDictionary = ["isValid": 1]
        testBool = try! TestBool(JSON: testIntDictionary)
        XCTAssert(testBool.isValid == true)
        
        let testStringExceptionDictionary = ["isValid": "xxx"]
        do {
            _ = try TestBool(JSON: testStringExceptionDictionary)
        } catch {
            print(error.localizedDescription)
            XCTAssert(true)
        }
    }
    
    func testTransformedValue() {
        var testBool = try! TestTransformedValue(JSON: testStringDictionary)
        XCTAssert(testBool.isValid.value == true)
        
        let testIntDictionary = ["isValid": 1]
        testBool = try! TestTransformedValue(JSON: testIntDictionary)
        XCTAssert(testBool.isValid.value == true)
    }

    func testTwoWayTransformed() {
        let testBool = try! TwoWayBoolModel(JSON: testStringDictionary)
        XCTAssert(testBool.isValid.target! == true)
        XCTAssert(testBool.toJSONStringSafely()! == "{\"isValid\":\"true\"}")
        
        let falseBool = TwoWayBoolModel(isValid: TwoWayTransformed<BoolStringTransformer>(target: false))
        XCTAssert(falseBool.toJSONStringSafely()! == "{\"isValid\":\"false\"}")
    }
}

struct TestBool: Decodable {
    let isValid: Bool
    
    private enum CodingKeys: String, CodingKey {
        case isValid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isValid = try container.decode(.isValid, transformer: BoolTransformer())
    }
}

struct TestTransformedValue: Decodable {
    let isValid: TransformedValue<BoolTransformer>
}

struct TwoWayBoolModel: Codable {
    let isValid: TwoWayTransformed<BoolStringTransformer>
}

struct BoolStringTransformer: CodingContainerTransformer {
    public typealias Input = String
    public typealias TargetType = Bool
    
    init() {
    }
    
    func transform(_ decoded: String) throws -> Bool {
        if decoded == "true" {
            return true
        } else {
            return false
        }
    }
    
    func transform(target: Bool) throws -> String {
        return target ? "true" : "false"
    }

}
