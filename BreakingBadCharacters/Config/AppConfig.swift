//
//  AppConfig.swift
//  BreakingBadCharacters
//
//  Created by Voro on 2.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit

struct AppConfig {
    
    static var apiBaseUrl: String {
        return configValue(for: "API_BASE_URL")
    }
    
    static var stubResponses: Bool {
        return configValue(for: "STUB_RESPONSE")
    }
    
    static let mainColor = UIColor(red: 0.11, green: 0.30, blue: 0.22, alpha: 1.00)
    static let mainColodDisabled = UIColor(red: 0.11, green: 0.30, blue: 0.22, alpha: 0.50)

    static func configValue<T>(for key: String) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            fatalError("Missing Info.plist key: \(key)")
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            fatalError("Invalid value with key: \(key)")
        }
    }
}
