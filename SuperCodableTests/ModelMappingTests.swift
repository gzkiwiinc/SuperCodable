//
//  ModelMappingTests.swift
//  SuperCodableTests
//
//  Created by 卓同学 on 2018/7/2.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import XCTest
@testable import SuperCodable

class ModelMappingTests: XCTestCase {
    
    struct MissionModel: Decodable {
        let type: String
        let content: MissionContent
    }
    
    struct MissionContent: Decodable {
        let hotpointRoutes: [HotpointRoutes]
    }
    
    struct HotpointRoutes: Decodable {
        let angle: Int
        let area: [Location]
        let radius: Double
        let lines: [[Location]]
    }
    
    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }
    
    func testMapping() {
        let decoder = JSONDecoder()
        let value = try! decoder.decode(DecodableValue.self, from: json)
        let dict = value.compactDictionary!
        let mission = try! MissionModel(JSON: dict)!
        XCTAssert(mission.content.hotpointRoutes.first!.lines.count == 4)
    }
    
    let json = """
    {
    "content" : {
    "hotpointRoutesStore" : [
    
    ],
    "hotpointRoutes" : [
    {
    "angle" : 45,
    "area" : [
    {
    "lat" : 30.523707112805059,
    "lng" : 119.9777285274059
    },
    {
    "lat" : 30.522707812333241,
    "lng" : 119.9781851450592
    },
    {
    "lat" : 30.524056464623509,
    "lng" : 119.97875885647299
    }
    ],
    "radius" : 50,
    "lines" : [
    [
    {
    "lat" : 30.523710954853779,
    "lng" : 119.977738668269
    },
    {
    "lat" : 30.523933615596221,
    "lng" : 119.9782259577625
    },
    {
    "lat" : 30.523067509243479,
    "lng" : 119.979210745546
    }
    ],
    [
    {
    "lat" : 30.524156276338669,
    "lng" : 119.9787132472559
    },
    {
    "lat" : 30.523933615596221,
    "lng" : 119.9782259577625
    },
    {
    "lat" : 30.523710954853779,
    "lng" : 119.977738668269
    },
    {
    "lat" : 30.523166571306191,
    "lng" : 119.9779874174141
    },
    {
    "lat" : 30.522622187758589,
    "lng" : 119.9782361665591
    }
    ],
    [
    {
    "lat" : 30.522622187758589,
    "lng" : 119.9782361665591
    },
    {
    "lat" : 30.524156276338669,
    "lng" : 119.9787132472559
    }
    ],
    [
    {
    "lat" : 30.523067509243479,
    "lng" : 119.979210745546
    },
    {
    "lat" : 30.52284484850103,
    "lng" : 119.97872345605261
    },
    {
    "lat" : 30.522622187758589,
    "lng" : 119.9782361665591
    },
    {
    "lat" : 30.523710954853779,
    "lng" : 119.977738668269
    }
    ]
    ],
    "speed" : 6,
    "overlap" : 50,
    "waypoints" : [
    {
    "lat" : 30.523710954853779,
    "lng" : 119.977738668269
    },
    {
    "lat" : 30.523933615596221,
    "lng" : 119.9782259577625
    },
    {
    "lat" : 30.524156276338669,
    "lng" : 119.9787132472559
    },
    {
    "lat" : 30.523611892791081,
    "lng" : 119.978961996401
    },
    {
    "lat" : 30.523067509243479,
    "lng" : 119.979210745546
    }
    ],
    "altitude" : 80,
    "name" : "2018-3-1 上午10:56:55"}]},
"type" : "missionDynamicConfigData"
}
""".data(using: .utf8)!

}
