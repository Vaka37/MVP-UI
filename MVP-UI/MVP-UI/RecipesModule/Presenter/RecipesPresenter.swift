// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для рецент
protocol RecipesPresenterInputProtocol: AnyObject {
    /// Получение данных от категорий
    func requestDataCategory()
    /// Метод по тапу на ячейку
    func tappedOnCell(type: Category)
}

/// Презентер для рецептов
final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var recipesCoordinator: RecipesCoordinator?
    private weak var view: CategoryViewInputProtocol?

    // MARK: - Initializers

    init(view: CategoryViewInputProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }
}

// MARK: - Extension + RecipesProtocol

extension RecipesPresenter: RecipesPresenterInputProtocol {
    func requestDataCategory() {
        let storage = Storage()
        view?.updateData(category: storage)
    }

    func tappedOnCell(type: Category) {
        recipesCoordinator?.pushDetailViewController(category: type)
    }
}
