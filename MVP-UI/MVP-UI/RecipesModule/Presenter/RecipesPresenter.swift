// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Протокол для рецент
protocol RecipesPresenterInputProtocol: AnyObject {
    /// Получение данных от категорий
    func requestDataCategory()

//    func tappedOnCell(type: CategoryType)
}

/// Презентер для рецептов
final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var recipesCoordinator: RecipesCoordinator?
    private weak var view: CategoryViewInputProtocol?

    init(view: CategoryViewInputProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }
}

// MARK: - extension + RecipesProtocol

extension RecipesPresenter: RecipesPresenterInputProtocol {
    func requestDataCategory() {
        let dataCategory = Storage()
        let categories = dataCategory.category.map(\.categoryTitle)
        view?.updateData(category: categories)
    }

    func tappedOnCell(type: CategoryType) {
        recipesCoordinator?.pushDetailViewController()
    }
}
