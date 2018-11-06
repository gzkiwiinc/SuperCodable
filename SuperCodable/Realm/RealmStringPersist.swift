//
//  JSONStringCacheModel.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/11/5.
//  Copyright © 2018 kiwi. All rights reserved.
//

import Foundation
import RealmSwift

public protocol RealmStringPersist {
    var primaryKey: String { get }
    var persistedStringValue: String { get }
    static var realmTypeId: String { get }
    var persistDestination: Realm? { get }
}

extension RealmStringPersist {
    var realPrimaryKey: String {
        return "\(Self.realmTypeId)-\(primaryKey)"

    }
    
    static func generateRealPrimaryKey(key: String) -> String {
        return "\(Self.realmTypeId)-\(key)"
    }
    
    func toRealmObject() -> RealmStringCacheModel {
        return RealmStringCacheModel(model: self)
    }
    
    public var persistDestination: Realm? {
        return nil
    }

}

class RealmStringCacheModel: Object {
    @objc dynamic var primaryKey = ""
    @objc dynamic var stringValue = ""
    @objc dynamic var typeId = ""

    convenience init(model: RealmStringPersist) {
        self.init()
        primaryKey = model.realPrimaryKey
        stringValue = model.persistedStringValue
        typeId = type(of: model).realmTypeId
    }
    
    override static func primaryKey() -> String? {
        return "primaryKey"
    }
}

public extension RealmStringPersist where Self: Codable {
    
    public var persistedStringValue: String {
        return self.toJSONStringSafely() ?? ""
    }

    public static var realmTypeId: String {
        return String(describing: Self.self)
    }
    
    @discardableResult
    public func save() -> Bool {
        guard let realm = getRealmInstance() else {
            return false
        }
        do {
            try realm.write {
                realm.add(toRealmObject(), update: true)
            }
            return true
        } catch  {
            return false
        }
    }

    public static func loadFromCache(primaryKey: String, from realm: Realm? = nil) -> Self? {
        var queryRealm: Realm!
        if let realm = realm {
            queryRealm = realm
        } else if let realm = RealmCache.defaultRealm {
            queryRealm = realm
        } else {
            return nil
        }
        guard let cacheModel = queryRealm.objects(RealmStringCacheModel.self).filter("primaryKey = %@", Self.generateRealPrimaryKey(key: primaryKey)).first else { return nil }
        return try? Self(JSONString: cacheModel.stringValue)
    }
    
    @discardableResult
    public func removeFromCache() -> Bool {
        guard let realm = getRealmInstance() else {
            return false
        }
        do {
            try realm.write {
                let reslut = realm.objects(RealmStringCacheModel.self).filter("primaryKey = %@", self.realPrimaryKey)
                if let object = reslut.first {
                    realm.delete(object)
                }
            }
            return true
        } catch {
            return false
        }
    }
    
    public static func removeFromCache(primaryKey: String, from realm: Realm? = nil) {
        var queryRealm: Realm!
        if let realm = realm {
            queryRealm = realm
        } else if let realm = RealmCache.defaultRealm {
            queryRealm = realm
        } else {
            return
        }
        try? queryRealm.write {
            let reslut = queryRealm.objects(RealmStringCacheModel.self).filter("primaryKey = %@", Self.generateRealPrimaryKey(key: primaryKey))
            if let object = reslut.first {
                queryRealm.delete(object)
            }
        }
    }
    
    private func getRealmInstance() -> Realm? {
        if let realm = persistDestination {
            return realm
        } else if let realm = RealmCache.defaultRealm {
            return realm
        } else {
            assertionFailure("don't cinfig realm db yet")
            return nil
        }
    }
}

