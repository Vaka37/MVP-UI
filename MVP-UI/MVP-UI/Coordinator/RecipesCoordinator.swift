// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с рецептами
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController
    var onFinishFlow: ((_: String) -> Void)?

    init(rootController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: rootController)
    }

    func pushDetailViewController() {
        debugPrint("Переход на экран с рецептами")
    }
}
