// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с рецептами
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var onFinishFlow: ((_: String) -> Void)?
    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushDetailViewController() {}
}
