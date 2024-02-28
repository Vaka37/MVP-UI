// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    private var tabBarViewController: TabBarController?
    private var appBuilder = AppBulder()
    override func start() {
        toAutorization()
    }

    private func tabBarMain() {
        tabBarViewController = TabBarController()

        let recipesModule = appBuilder.makeRecipesViewController()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesModule)
        recipesModule.recipesPresenter?.recipesCoordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        let favoritesModule = appBuilder.makeFavoritesViewController()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesModule)
        favoritesModule.favoritesPresenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        let userProfileModule = appBuilder.makeUserProfileViewController()
        let userProfileCoordinator = UserProfileCoordinator(rootController: userProfileModule)
        add(coordinator: userProfileCoordinator)

        tabBarViewController?.setViewControllers(
            [
                recipesCoordinator.rootViewController,
                favoritesCoordinator.rootViewController,
                userProfileCoordinator.rootViewController
            ],
            animated: false
        )
        guard let tabBarViewController = tabBarViewController else { return }

        setAsRoot​(​_​: tabBarViewController)
    }

    private func toAutorization() {
        let autorizationCoordinator = AutorizationCoordinator()
        autorizationCoordinator.onFihishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.tabBarMain()
        }
        add(coordinator: autorizationCoordinator)
        autorizationCoordinator.start()
    }
}
