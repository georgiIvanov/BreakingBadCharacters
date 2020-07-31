//
//  Storyboard.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

enum Storyboard: String {
    case main = "Main"

    func instantiate<VC: UIViewController>(_ viewController: VC.Type, inBundle bundle: Bundle? = nil) -> VC {

        let swinStoryboard = SwinjectStoryboard.create(name: self.rawValue,
                                                       bundle: bundle,
                                                       container: AppDelegate.container)
        let instance = swinStoryboard.instantiateViewController(withIdentifier: VC.storyboardIdentifier)

        guard let viewController = instance as? VC else {
            fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue) storyboard")
        }

        return viewController
    }

    func initialViewController() -> UIViewController? {
        return SwinjectStoryboard.create(name: self.rawValue,
                                         bundle: nil,
                                         container: AppDelegate.container).instantiateInitialViewController()
    }
}
