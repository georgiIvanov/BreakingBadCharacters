//
//  ViewControllerAssembly.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.storyboardInitCompleted(CharactersViewController.self) { (res, controller) in

        }
    }
}
