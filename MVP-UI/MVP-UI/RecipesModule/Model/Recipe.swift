// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Составляющая рецепта
struct Recipe {
    /// Аватар рецепта
    var avatarRecipie: String
    /// Название рецепта
    var titleRecipies: String
    /// Время изготовления блюда
    var cookingTimeTitle: String
    /// Калории блюда
    var caloriesTitle: String
    /// Питательные вещества
    var nutrientsValue: [String]
    /// Описание рецепта
    var recipeDescriptionTitle: String
    /// Порция (в граммах)
    var portionWeight: String
}
