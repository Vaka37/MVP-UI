// RecipeDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Слой детальных рецептов
final class RecipeDetail {
    /// Заголовок
    let label: String
    /// Время приготовления
    let totalTime: Int
    /// Кол-во калорий
    let calories: Int
    /// Картинка рецепта
    let images: String
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: [String: Total]
    /// Описание рецепта
    let ingridientLines: [String]

    init(dto: DetailDTO) {
        label = dto.label
        totalTime = dto.totalTime
        calories = Int(dto.calories)
        images = dto.images.regular.url
        totalWeight = dto.totalWeight
        totalNutrients = dto.totalNutrients
        ingridientLines = dto.ingredientLines
    }
}
