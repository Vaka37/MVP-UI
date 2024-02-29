// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с фаворитами
final class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }
}
