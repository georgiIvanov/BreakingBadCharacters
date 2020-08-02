//
//  Data+Extensions.swift
//  BreakingBadCharacters
//
//  Created by Voro on 2.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation

extension Data {
    static func jsonData(fileName: String) -> Data? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let url = URL(string: "file://\(path)")!
        let data = try? Data(contentsOf: url)
        return data
    }
}
