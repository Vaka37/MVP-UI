// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Протокол для рецент
protocol RecipesProtocol: AnyObject {
    /// Метод для тапа по ячейки
    func tappedOnCell()
}

/// Презентер для рецептов
final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var recipesCoordinator: RecipesCoordinator?

    init(view: UIViewController, coordinator: RecipesCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }
}

// MARK: - extension + RecipesProtocol

extension RecipesPresenter: RecipesProtocol {
    func tappedOnCell() {
        recipesCoordinator?.pushDetailViewController()
    }
}
