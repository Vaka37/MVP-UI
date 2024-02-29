// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с рецептами
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushDetailViewController(category: Category) {
        let recipiesViewController = RecipesListViewController()
        let presenter = RecipePresenter(view: recipiesViewController, category: category)
        recipiesViewController.recipePresenter = presenter
        rootViewController?.pushViewController(recipiesViewController, animated: true)
    }
}
