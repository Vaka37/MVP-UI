// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

//
//  AutorizationCoordinator.swift
//  MVP-UI
//
//  Created by Kalandarov Vakil on 27.02.2024.
//
import UIKit

/// Координатор авторизации
final class AutorizationCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var onFihishFlow: (() -> ())?

    override func start() {
        showAutorizationViewController()
    }

    func showAutorizationViewController() {
        let authViewController = AutorizationViewController()
        let authPresenter = AutorizationPresenter(view: authViewController)
        authViewController.autorizationPresenter = authPresenter
        authPresenter.autorizationCoordinator = self

        let rootController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootController)
        rootViewController = rootController
    }
}
