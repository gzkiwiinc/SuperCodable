//
//  SuperCodableError.swift
//  SuperCodable
//
//  Created by 卓同学 on 2018/6/29.
//  Copyright © 2018年 kiwi. All rights reserved.
//

import Foundation

public enum SuperCodableError: LocalizedError {
    case mappingJSONFailed
    case encodingDataFailed(Any)
    
    var errorDescription: String {
        switch self {
        case .mappingJSONFailed:
            return "mapping encoded data to json failed"
        case .encodingDataFailed:
            return "given value encoding failed"
        }
    }
}
