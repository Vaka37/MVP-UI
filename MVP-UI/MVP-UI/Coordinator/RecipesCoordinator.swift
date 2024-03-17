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
        let presenter = RecipePresenter(
            view: recipiesViewController,
            category: category,
            detailsRecipeCoordinator: self
        )
        recipiesViewController.recipePresenter = presenter
        rootViewController?.pushViewController(recipiesViewController, animated: true)
        recipiesViewController.tabBarController?.tabBar.isHidden = true
    }

    func pushRecipeDetailsViewController(recipe: RecipeCommonInfo) {
        let recipesDetailsViewController = RecipesDetailsViewController()
        let presenter = DetailsPresenter(view: recipesDetailsViewController, recipe: recipe, recipesCoordinator: self)
        recipesDetailsViewController.detailsPresenter = presenter
        rootViewController?.pushViewController(recipesDetailsViewController, animated: true)
    }
}
