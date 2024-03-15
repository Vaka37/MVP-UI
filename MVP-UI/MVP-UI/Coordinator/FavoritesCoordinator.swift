// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для экрана с избарнным
final class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushRecipeDetailsViewController(recipe: RecipeCommonInfo) {
        let recipesDetailsViewController = RecipesDetailsViewController()
        let presenter = DetailsPresenter(
            view: recipesDetailsViewController,
            recipe: recipe,
            recipesCoordinator:
            self
        )
        recipesDetailsViewController.detailsPresenter = presenter
        rootViewController?.pushViewController(recipesDetailsViewController, animated: true)
    }
}
