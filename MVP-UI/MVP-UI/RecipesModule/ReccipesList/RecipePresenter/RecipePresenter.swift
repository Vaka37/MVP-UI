// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol RecipesViewProtocol: AnyObject {
    func getRecipes(recipes: [Recipie])
}

protocol RecipeProtocol: AnyObject {
    func getUser()
}

final class RecipePresenter {
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipesCoordinator?
    private var user: Recipie?

    init(view: RecipesViewProtocol) {
        self.view = view
    }
}

extension RecipePresenter: RecipeProtocol {
    func getUser() {
        let storage = Storage()
        view?.getRecipes(recipes: storage.fish)
    }
}
