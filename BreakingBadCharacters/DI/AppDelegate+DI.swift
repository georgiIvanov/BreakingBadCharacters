//
//  AppDelegate+DI.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import Swinject

extension AppDelegate: DIContainer {

    static let container: Container = {
        return createContainer()
    }()

}
