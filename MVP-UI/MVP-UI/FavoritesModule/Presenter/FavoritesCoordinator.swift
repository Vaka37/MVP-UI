// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController
    var onFinishFlow: ((_: String) -> Void)?

    init(rootController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: rootController)
    }
}
