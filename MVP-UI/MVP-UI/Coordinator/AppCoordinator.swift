// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    private var tabBarViewController: TabBarController?
    private var appBuilder = AppBulder()
    override func start() {
//        toAutorization()
        tabBarMain()
    }

    private func tabBarMain() {
        tabBarViewController = TabBarController()

        let recipesCoordinator = RecipesCoordinator()
        let recipesModule = appBuilder.makeRecipesViewController(recipecCoordinator: recipesCoordinator)
        recipesCoordinator.setRootController(viewController: recipesModule)
        add(coordinator: recipesCoordinator)

        let favoriteCoordinator = FavoritesCoordinator()
        let favoritesModule = appBuilder.makeFavoritesViewController(favoritesCoordinator: favoriteCoordinator)
        favoriteCoordinator.setRootController(viewController: favoritesModule)
        add(coordinator: favoriteCoordinator)

        let userCoordinator = UserProfileCoordinator()
        let userProfileModule = appBuilder.makeUserProfileViewController(userProfileUserCoordinator: userCoordinator)
        userCoordinator.setRootController(viewController: userProfileModule)
        add(coordinator: userCoordinator)

        guard let recipesRootViewController = recipesCoordinator.rootViewController else { return }
        guard let favoriteViewController = favoriteCoordinator.rootViewController else { return }
        guard let userViewController = userCoordinator.rootViewController else { return }

        tabBarViewController?.setViewControllers(
            [
                recipesRootViewController,
                favoriteViewController,
                userViewController
            ],
            animated: false
        )
        guard let tabBarViewController = tabBarViewController else { return }

        setAsRoot​(​_​: tabBarViewController)
    }

    private func toAutorization() {
        let autorizationCoordinator = AutorizationCoordinator()
        autorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.tabBarMain()
        }
        add(coordinator: autorizationCoordinator)
        autorizationCoordinator.start()
    }
}
