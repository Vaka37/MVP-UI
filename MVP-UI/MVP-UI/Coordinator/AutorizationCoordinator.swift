// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

//
//  AutorizationCoordinator.swift
//  MVP-UI
//
//
import UIKit

/// Координатор авторизации
final class AutorizationCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    override func start() {
        showAutorizationViewController()
    }

    func showAutorizationViewController() {
        let autorizationCoordinator = AutorizationCoordinator()
        let authViewController = AutorizationViewController()
        let loginPresenter = AutorizationPresenter(view: authViewController, coordinator: autorizationCoordinator)
        authViewController.autorizationPresenter = loginPresenter

        let rootViewController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }
}
