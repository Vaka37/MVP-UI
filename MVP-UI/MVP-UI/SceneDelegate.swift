// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDelegate(windowScene: windowScene)
        let networkService = NetworkService()
        //TODO: - Запросы для проверки данных
        networkService.getRecipe { _ in
        }
        networkService
            .getDetail(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_e074fb5e814ed30309780398e68c2b90") { _ in
            }
    }

    private func configureSceneDelegate(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            applicationCoordinator = ApplicationCoordinator()
            applicationCoordinator?.start()
        }
    }
}
