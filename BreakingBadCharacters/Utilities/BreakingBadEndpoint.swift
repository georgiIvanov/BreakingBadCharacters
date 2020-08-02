//
//  BreakingBadEndpoint.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import Moya

typealias BreakingBadApi = MoyaProvider<BreakingBadEndpoint>

enum BreakingBadEndpoint {
    case characters
}

extension BreakingBadEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://\(AppConfig.apiBaseUrl)/api/")!
    }

    var path: String {
        switch self {
        case .characters:
            return "characters"
        }
    }

    var method: Moya.Method {
        switch self {
        case .characters:
            return .get
        }
    }

    var sampleData: Data {
        // TODO: Add stub response
        return Data()
    }

    var task: Task {
        switch self {
        case .characters:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
