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
    /// Парсинг детальной информации
    func parsingDetail()
}

/// Презентер детального экрана рецептов
final class DetailsPresenter {
    // MARK: - Private Properties

    private weak var recipesCoordinator: BaseCoordinator?
    private weak var view: DetailsViewInputProtocol?
    private var recipe: RecipeCommonInfo
    private var isFavorites = false
    private let networkService = NetworkService()
    private var recipeDetail: RecipeDetail?

    // MARK: - Initializers

    init(view: DetailsViewInputProtocol, recipe: RecipeCommonInfo, recipesCoordinator: BaseCoordinator) {
        self.view = view
        self.recipe = recipe
        self.recipesCoordinator = recipesCoordinator
        parsingDetail()
    }
}

// MARK: - Extension + DetailsPresenterInputProtocol

extension DetailsPresenter: DetailsPresenterInputProtocol {
    func parsingDetail() {
        networkService.getDetail(uri: recipe.uri) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    self.recipeDetail = recipes
                    guard let recipeDetail = self.recipeDetail else { return }
                    self.view?.getDetail(recipe: recipeDetail)
                case .failure:
                    break
                }
            }
        }
    }

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
            if item.label == recipe.label {
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
        guard let recipeDetail = recipeDetail else { return }
        view?.getDetail(recipe: recipeDetail)
    }
}
