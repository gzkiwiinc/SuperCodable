//
//  RealmCacheTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/11/5.
//  Copyright © 2018 kiwi. All rights reserved.
//

import XCTest
import RealmSwift
@testable import SuperCodable

class RealmCacheTests: XCTestCase {
    
    struct TestModel: Codable, RealmStringPersist {
        var primaryKey: String
        let name: String
    }
    
    override func setUp() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
        RealmCache.defaultRealm = realm
    }
    
    private let primaryKey = "test1"
    func testCacheModel() {
        let model = TestModel(primaryKey: primaryKey, name: "xxx")
        XCTAssert(model.save())
        if let queryModel = TestModel.loadFromCache(primaryKey: primaryKey) {
            XCTAssert(queryModel.name == "xxx")
        } else {
            XCTFail()
        }
    }

    func testRemoveCacheModelStatic() {
        let model = TestModel(primaryKey: primaryKey, name: "yyy")
        XCTAssert(model.save())
        XCTAssertNotNil(TestModel.loadFromCache(primaryKey: primaryKey))
        TestModel.removeFromCache(primaryKey: primaryKey)
        XCTAssertNil(TestModel.loadFromCache(primaryKey: primaryKey))
    }
    
    func testRemoveCacheModel() {
        let model = TestModel(primaryKey: primaryKey, name: "yyy")
        XCTAssert(model.save())
        XCTAssertNotNil(TestModel.loadFromCache(primaryKey: primaryKey))
        model.removeFromCache()
        XCTAssertNil(TestModel.loadFromCache(primaryKey: primaryKey))
    }
}
