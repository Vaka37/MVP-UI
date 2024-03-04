// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для фаворитов
protocol FavoritesProtocol: AnyObject {
    /// Метод для перехода
    func pushDetailFavoritesViewController()
    /// Методд для проверки пустые ли фавориты
    func emptyView()
}

/// Протокол фаворитов для вью
protocol FavoritesViewProtocol: AnyObject {
    /// Методд для проверки пустые ли фавориты
    func emptyFaforites()
}

/// Презентер для экрана с фаворитами
final class FavoritesPresenter {
    private weak var favoritesCoordinator: FavoritesCoordinator?
    private weak var view: FavoritesViewProtocol?

    init(view: FavoritesViewProtocol, favoritesCoordinator: FavoritesCoordinator) {
        self.view = view
        self.favoritesCoordinator = favoritesCoordinator
    }
}

// MARK: - extension + FavoritesProtocol

extension FavoritesPresenter: FavoritesProtocol {
    func emptyView() {
        view?.emptyFaforites()
    }

    func pushDetailFavoritesViewController() {}
}
