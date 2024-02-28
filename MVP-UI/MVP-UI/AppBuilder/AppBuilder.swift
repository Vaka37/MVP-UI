// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
class AppBulder {
    func makeRecipesViewController() -> RecipesViewController {
        let recepisViewController = RecipesViewController()
        let recepisPresenter = RecipesPresenter(view: recepisViewController)
        recepisViewController.recipesPresenter = recepisPresenter
        recepisViewController.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage.recipes,
            selectedImage: UIImage.recipesFill
        )

        return recepisViewController
    }

    func makeFavoritesViewController() -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(view: favoritesViewController)
        favoritesViewController.favoritesPresenter = favoritesPresenter
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage.favorites,
            selectedImage: UIImage.favoritesFill
        )
        return favoritesViewController
    }

    func makeUserProfileViewController() -> UserProfileViewController {
        let userProfileViewController = UserProfileViewController()
        let userProfilePresenter = UserProfilePresenter(view: userProfileViewController)
        userProfileViewController.userProfilePresenter = userProfilePresenter
        userProfileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.smile,
            selectedImage: UIImage.smileFill
        )
        return userProfileViewController
    }
}
