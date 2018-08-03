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
    
    func testBoolTransformer() {
        let testStringDictionary = ["isValid": "true"]
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
        let testStringDictionary = ["isValid": "true"]
        var testBool = try! TestTransformedValue(JSON: testStringDictionary)
        XCTAssert(testBool.isValid.value == true)
        
        let testIntDictionary = ["isValid": 1]
        testBool = try! TestTransformedValue(JSON: testIntDictionary)
        XCTAssert(testBool.isValid.value == true)
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
