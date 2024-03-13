// RecipesStorage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// создание модели для хранения рецептов
final class RecipesStorage {
    /// картинка
    let image: String
    /// заголловок
    let label: String
    /// время приготовллениия
    let totaltime: Double
    /// калории
    let calories: Int
    /// URI
    let uri: String

    init(dto: RecipeDTO) {
        image = dto.image
        label = dto.label
        totaltime = dto.totalTime
        calories = Int(dto.calories)
        uri = dto.uri
    }
}
