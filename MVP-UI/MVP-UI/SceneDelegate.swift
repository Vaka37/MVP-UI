// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var applicationCoordinator: ApplicationCoordinator?
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDeklegate(windowScene: windowScene)
    }

    private func configureSceneDeklegate(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            applicationCoordinator = ApplicationCoordinator()
            applicationCoordinator?.start()
        }
    }
}
