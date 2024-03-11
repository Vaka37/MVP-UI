// DetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол рецепта
protocol DetailsPresenterInputProtocol {
    /// данные экрана рецептов
    func getDetail()
    /// Проверка рецепта на избранное
    func checkFavorite()
    /// Добавление или удаление из избраного
    func changeFavorites()
}

/// Презентер детального экрана рецептов
final class DetailsPresenter {
    // MARK: - Private Properties

    private weak var recipesCoordinator: BaseCoordinator?
    private weak var view: DetailsViewInputProtocol?
    private var recipe: Recipe
    private var isFavorites = false

    // MARK: - Initializers

    init(view: DetailsViewInputProtocol, recipe: Recipe, recipesCoordinator: BaseCoordinator) {
        self.view = view
        self.recipe = recipe
        self.recipesCoordinator = recipesCoordinator
    }
}

// MARK: - Extension + DetailsPresenterInputProtocol

extension DetailsPresenter: DetailsPresenterInputProtocol {
    func changeFavorites() {
        let favoriteService = FavoritesService.shared
        if !isFavorites {
            favoriteService.favorites.append(recipe)
        } else {
            if let index = favoriteService.favorites.firstIndex(of: recipe) {
                favoriteService.favorites.remove(at: index)
            }
        }
        checkFavorite()
        favoriteService.saveFavorites()
    }

    func checkFavorite() {
        let servis = FavoritesService.shared
        if servis.favorites.isEmpty { view?.noFavorite() }
        for item in servis.favorites {
            if item.titleRecipies == recipe.titleRecipies {
                view?.isFavorite()
                isFavorites = true
                return
            } else {
                view?.noFavorite()
                isFavorites = false
            }
        }
    }

    func getDetail() {
        view?.getDetail(recipe: recipe)
    }
}
