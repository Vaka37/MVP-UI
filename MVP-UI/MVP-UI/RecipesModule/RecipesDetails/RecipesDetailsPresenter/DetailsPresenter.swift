// DetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол рецепта
protocol DetailsPresenterInputProtocol {
    /// данные экрана рецептов
    func getDetail()
}

/// Презентер детального экрана рецептов
final class DetailsPresenter {
    // MARK: - Private Properties

    private weak var recipesCoordinator: RecipesCoordinator?
    private weak var view: DetailsViewInputProtocol?
    private var recipe: Recipe

    // MARK: - Initializers

    init(view: DetailsViewInputProtocol, recipe: Recipe, recipesCoordinator: RecipesCoordinator) {
        self.view = view
        self.recipe = recipe
        self.recipesCoordinator = recipesCoordinator
    }
}

// MARK: - Extension + DetailsPresenterInputProtocol

extension DetailsPresenter: DetailsPresenterInputProtocol {
    func getDetail() {
        view?.getDetail(recipe: recipe)
    }
}
