//
//  BreakingBadApiService.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation

protocol BreakingBadApiServiceProtocol: class {

}

class BreakingBadApiService {
    let breakingBadApi: BreakingBadApi

    init(breakingBadApi: BreakingBadApi) {
        self.breakingBadApi = breakingBadApi
    }
}

extension BreakingBadApiService: BreakingBadApiServiceProtocol {

}
