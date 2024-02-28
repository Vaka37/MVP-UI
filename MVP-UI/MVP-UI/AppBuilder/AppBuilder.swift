// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
final class AppBulder {
    func makeRecipesViewController(recipecCoordinator: RecipesCoordinator) -> RecipesViewController {
        let recepisViewController = RecipesViewController()
        let recepisPresenter = RecipesPresenter(view: recepisViewController, coordinator: recipecCoordinator)
        recepisViewController.recipesPresenter = recepisPresenter
        recepisViewController.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage.recipes,
            selectedImage: UIImage.recipesFill
        )
        return recepisViewController
    }

    func makeFavoritesViewController(favoritesCoordinator: FavoritesCoordinator) -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(
            view: favoritesViewController,
            favoritesCoordinator: favoritesCoordinator
        )
        favoritesViewController.favoritesPresenter = favoritesPresenter
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage.favorites,
            selectedImage: UIImage.favoritesFill
        )
        return favoritesViewController
    }

    func makeUserProfileViewController(
        userProfileUserCoordinator: UserProfileCoordinator
    ) -> UserProfileViewController {
        let view = UserProfileViewController()
        let presenter = UserProfilePresenter(view: view, userCoordinator: userProfileUserCoordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.smile,
            selectedImage: UIImage.smileFill
        )
        return view
    }
}
