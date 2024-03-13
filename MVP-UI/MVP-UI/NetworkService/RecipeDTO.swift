// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Recipe ResponseDTO
struct RecipeResponseDTO: Codable {
    /// Массив рецептов
    let hits: [RecipeHitDTO]
}

/// RecipeHitDTO
struct RecipeHitDTO: Codable {
    /// Peцепт
    let recipe: RecipeDTO
}

///
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

/// Струкрутра данных рецептов
struct DetailsDTO: Decodable {
    let image: String
    let label: String
    let totalTime: Double
    let calories: Double
    let images: ImagesDTO
    let totalWeight: Double
    let totalNutrients: TotalNutrientsDTO
    let ingridientLines: [String]
}

/// Структура данных картинок
struct ImagesDTO: Decodable {
    let regular: LagreDTO
}

/// Структура данных ссылки на картинку
struct LagreDTO: Decodable {
    let url: String
}

/// Структура данных питательных веществ
struct TotalNutrientsDTO: Decodable {
    let kcal: String
    let carbohydrates: String
    let fats: String
    let proteins: String

    /// Перечисление ключей кодирования
    enum CodingKeys: String, CodingKey {
        /// для каллорий
        case kcal = "ENERC_KCAL"
        /// для углеводов
        case carbohydrates = "CHOCDE"
        /// для жиров
        case fats = "FAT"
        /// для белков
        case proteins = "PROCNT"
    }
}
