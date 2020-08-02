//
//  BreakingBadCharacter.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation

struct BreakingBadCharacter: Codable {
    let charId: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String
    let betterCallSaulAppearance: [Int]
    
    var imageURL: URL? {
        return URL(string: img)
    }
    
    func joinOccupations() -> String {
        return occupation.joined(separator: ", ")
    }
    
    func joinSeasonAppearance() -> String {
        return appearance.map { "\($0)" }.joined(separator: ", ")
    }
}
