// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// РецептDTO
struct RecipeResponseDTO: Codable {
    /// Массив рецептов
    let hits: [RecipeHitDTO]
}

/// RecipeHitDTO
struct RecipeHitDTO: Codable {
    /// Peцепт
    let recipe: RecipeDTO
}

/// Рецепт
struct RecipeDTO: Codable {
    /// Картинка
    let image: String
    /// Заголовок
    let label: String
    /// Время приготовления
    let totalTime: Double
    /// Калории
    let calories: Double
    /// URI
    let uri: String
}

/// DetailsResponseDTO
struct DetailsResponseDTO: Codable {
    let recipe: DetailDTO
}

/// Детальные рецепты
struct RecipeRetailDTO: Codable {
    /// Массив для запрса
    let hits: [DetailsResponseDTO]
}

/// Детальная струкрутра данных рецептов
struct DetailDTO: Codable {
    /// Заголовок
    let label: String
    /// Время приготовления
    let totalTime: Int
    /// Кол-во калорий
    let calories: Double
    /// Картинка рецепта
    let images: ImagesDTO
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: [String: Total]
    /// Описание рецепта
    let ingredientLines: [String]
}

/// Структура данных картинок
struct ImagesDTO: Codable {
    /// размер картинки
    let thumbnail, small, regular: LagreDTO
    /// Ссылка на картинку
    let large: LagreDTO?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

/// Структура данных ссылки на картинку
struct LagreDTO: Codable {
    /// Ссылка на картинку
    let url: String
}

/// Заголовки деталей
enum Label: String, Codable {
    case calcium = "Calcium"
    case carbohydratesNet = "Carbohydrates (net)"
    case carbs = "Carbs"
    case carbsNet = "Carbs (net)"
    case cholesterol = "Cholesterol"
    case energy = "Energy"
    case fat = "Fat"
    case fiber = "Fiber"
    case folateEquivalentTotal = "Folate equivalent (total)"
    case folateFood = "Folate (food)"
    case folicAcid = "Folic acid"
    case iron = "Iron"
    case magnesium = "Magnesium"
    case monounsaturated = "Monounsaturated"
    case niacinB3 = "Niacin (B3)"
    case phosphorus = "Phosphorus"
    case polyunsaturated = "Polyunsaturated"
    case potassium = "Potassium"
    case protein = "Protein"
    case riboflavinB2 = "Riboflavin (B2)"
    case saturated = "Saturated"
    case sodium = "Sodium"
    case sugarAlcohols = "Sugar alcohols"
    case sugars = "Sugars"
    case sugarsAdded = "Sugars, added"
    case thiaminB1 = "Thiamin (B1)"
    case trans = "Trans"
    case vitaminA = "Vitamin A"
    case vitaminB12 = "Vitamin B12"
    case vitaminB6 = "Vitamin B6"
    case vitaminC = "Vitamin C"
    case vitaminD = "Vitamin D"
    case vitaminE = "Vitamin E"
    case vitaminK = "Vitamin K"
    case water = "Water"
    case zinc = "Zinc"
}

/// Значения для ключей с деталями
struct Total: Codable {
    let label: Label
}
