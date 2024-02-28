// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для фаворитов
protocol FavoritesProtocol: AnyObject {
    /// Метод для перехода
    func pushDetailFavoritesViewController()
}

/// Презентер для экрана с фаворитами
final class FavoritesPresenter {
    private weak var favoritesCoordinator: FavoritesCoordinator?
    private weak var view: UIViewController?

    init(view: UIViewController, favoritesCoordinator: FavoritesCoordinator) {
        self.view = view
        self.favoritesCoordinator = favoritesCoordinator
    }
}

// MARK: - extension + FavoritesProtocol

extension FavoritesPresenter: FavoritesProtocol {
    func pushDetailFavoritesViewController() {}
}
