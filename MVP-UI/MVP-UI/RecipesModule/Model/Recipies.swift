// Recipies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Составляющая рецепта
struct Recipie {
    /// Аватар рецепта
    var avatarRecipie: String
    /// Название рецепта
    var titleRecipies: String
    /// Время изготовления блюда
    var cookingTimeTitle: String
    /// Калории блюда
    var caloriesTitle: String
    /// Питательные вещества
    var nutrientsTitle: NutrientsFields
    /// Описание рецепта
    var recipeDescriptionTitle: String
}

/// Составляющая питательных веществ блюда
struct NutrientsFields {
    var nutrientName: NutrientsNames
    var significance: NutrientsValues
}

/// Имена компонентов
struct NutrientsNames {
    /// Каллории
    var calories: String
    /// Углеводы
    var carbohydrates: String
    /// Жиры
    var fats: String
    /// Белки
    var proteins: String
}

/// Значения компонентов
struct NutrientsValues {
    /// Каллорий
    var energyKcal: String
    /// Углеводов
    var carbohydrates: String
    /// Жиров
    var fats: String
    /// Белков
    var proteins: String
}
