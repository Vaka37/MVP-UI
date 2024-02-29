// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol RecipesViewProtocol: AnyObject {
    func getRecipes(recipes: Category)
}

protocol RecipeProtocol: AnyObject {
    func getUser()
}

final class RecipePresenter {
    private weak var view: RecipesViewProtocol?
    private var category: Category

    init(view: RecipesViewProtocol, category: Category) {
        self.view = view
        self.category = category
    }
}

extension RecipePresenter: RecipeProtocol {
    func getUser() {
        view?.getRecipes(recipes: category)
    }
}
