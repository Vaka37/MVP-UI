// UserProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для  профиля
final class UserProfileCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushDetailViewController() {}
}
