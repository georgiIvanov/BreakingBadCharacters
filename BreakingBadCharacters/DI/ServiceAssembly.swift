//
//  ServiceAssembly.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Swinject
import Moya
import Alamofire

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        registerApiProvider(into: container)

        container.register(BreakingBadApiServiceProtocol.self) { (res) in
            return BreakingBadApiService(breakingBadApi: res.resolve(BreakingBadApi.self)!)
        }
    }
}

private extension ServiceAssembly {
    func registerApiProvider(into container: Container) {
            container.register(BreakingBadApi.self) { _ in

                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 30
                configuration.timeoutIntervalForResource = 30
                configuration.requestCachePolicy = .useProtocolCachePolicy

                let manager = Session.init(configuration: configuration)

                return BreakingBadApi(session: manager)
            }.singleton()
        }
}
