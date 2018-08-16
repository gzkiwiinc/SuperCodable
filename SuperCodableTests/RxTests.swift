//
//  RxTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/8/16.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import XCTest
@testable import SuperCodable
import RxSwift

extension Int: DecodeFailable {
    public static var decodeFailedValue: Int { return 0 }
}

class RxTests: XCTestCase {
    let json = """
{
    "code": 1,
    "stringValue": null
}
""".data(using: .utf8)!
    
    struct VariableModel: Codable {
        let code: Variable<Int>
        var stringValue: Variable<String?>
    }
    
    func testVariableCodable() {
        let model: VariableModel = try! json.decoded()
        XCTAssert(model.code.value == 1)
        XCTAssert(model.stringValue.value == nil)
    }
    
    
}
