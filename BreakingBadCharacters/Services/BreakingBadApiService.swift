//
//  BreakingBadApiService.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import RxSwift

protocol BreakingBadApiServiceProtocol: class {
    func fetchCharacters() -> Single<[BreakingBadCharacter]>
}

class BreakingBadApiService {
    let breakingBadApi: BreakingBadApi
    let jsonDecoder: JSONDecoder

    init(breakingBadApi: BreakingBadApi) {
        self.breakingBadApi = breakingBadApi
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

extension BreakingBadApiService: BreakingBadApiServiceProtocol {
    func fetchCharacters() -> Single<[BreakingBadCharacter]> {
        return breakingBadApi.rx.request(.characters)
            .map([BreakingBadCharacter].self, using: jsonDecoder)
    }
}
