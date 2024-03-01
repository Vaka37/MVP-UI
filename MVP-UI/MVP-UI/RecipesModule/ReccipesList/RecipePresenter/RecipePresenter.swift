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
}

/// Презентер детального экрана рецептов
final class RecipePresenter {
    // MARK: - Private Properties

    private weak var view: RecipesViewProtocol?
    private var category: Category

    // MARK: - Initializers

    init(view: RecipesViewProtocol, category: Category) {
        self.view = view
        self.category = category
    }
}

// MARK: - Extension + RecipeProtocol

extension RecipePresenter: RecipeProtocol {
    func getUser() {
        view?.getRecipes(recipes: category)
    }
}
