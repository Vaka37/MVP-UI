// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол получения категории
protocol RecipesViewProtocol: AnyObject {
    /// Получение категории
    func getRecipes(recipes: Category)
}

/// Протокол рецептов
protocol RecipeProtocol: AnyObject {
    func getUser()
    func tappedOnCell(recipe: Recipe)
}

/// Презентер экрана рецептов
final class RecipePresenter {
    // MARK: - Private Properties

    private weak var detailsRecipeCoordinator: RecipesCoordinator?
    private weak var view: RecipesViewProtocol?
    private var category: Category

    // MARK: - Initializers

    init(view: RecipesViewProtocol, category: Category, detailsRecipeCoordinator: RecipesCoordinator) {
        self.view = view
        self.category = category
        self.detailsRecipeCoordinator = detailsRecipeCoordinator
    }
}

// MARK: - Extension + RecipeProtocol

extension RecipePresenter: RecipeProtocol {
    func tappedOnCell(recipe: Recipe) {
        detailsRecipeCoordinator?.pushRecipeDetailsViewController(recipe: recipe)
    }

    func getUser() {
        view?.getRecipes(recipes: category)
    }
}
