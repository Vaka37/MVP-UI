// TotalDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Значения для ключей с деталями
struct TotalDTO: Codable {
    /// Заголовок
    let label: Label
}

/// Заголовки деталей
enum Label: String, Codable {
    /// Содержание кальция
    case calcium = "Calcium"
    /// Содержание углеводов
    case carbohydratesNet = "Carbohydrates (net)"
    /// Содержание углеводов
    case carbs = "Carbs"
    /// Содержание углеводов
    case carbsNet = "Carbs (net)"
    /// Содержание холестерина
    case cholesterol = "Cholesterol"
    /// Содержание каллорий
    case energy = "Energy"
    /// Содержание жиров
    case fat = "Fat"
    /// Содержание питательных волокон
    case fiber = "Fiber"
    /// Содержание фолатов (всего)
    case folateEquivalentTotal = "Folate equivalent (total)"
    /// Содержание фолатов кислоты в блюде
    case folateFood = "Folate (food)"
    /// Содержание фолиевой кислоты
    case folicAcid = "Folic acid"
    /// Содержание железа
    case iron = "Iron"
    /// Содержание магния
    case magnesium = "Magnesium"
    /// Содержание мононасыщенных веществ
    case monounsaturated = "Monounsaturated"
    /// Содержание ниацина
    case niacinB3 = "Niacin (B3)"
    /// Содержание фосфора
    case phosphorus = "Phosphorus"
    /// Содержание полиненасыщенных веществ
    case polyunsaturated = "Polyunsaturated"
    /// Содержание калия
    case potassium = "Potassium"
    /// Содержание белка
    case protein = "Protein"
    /// Содержание рибофлавина
    case riboflavinB2 = "Riboflavin (B2)"
    /// Содержание насыщенных веществ
    case saturated = "Saturated"
    /// Содержание натрия
    case sodium = "Sodium"
    /// Содержание сахара в спирте
    case sugarAlcohols = "Sugar alcohols"
    /// Содержание сахара
    case sugars = "Sugars"
    /// Содержание добавленноо сахара
    case sugarsAdded = "Sugars, added"
    /// Содержание тиамина
    case thiaminB1 = "Thiamin (B1)"
    /// Переход от одного состояния в другое
    case trans = "Trans"
    /// Содержание витамина А
    case vitaminA = "Vitamin A"
    /// Содержание витамина B12
    case vitaminB12 = "Vitamin B12"
    /// Содержание витамина B6
    case vitaminB6 = "Vitamin B6"
    /// Содержание витамина C
    case vitaminC = "Vitamin C"
    /// Содержание витамина D
    case vitaminD = "Vitamin D"
    /// Содержание витамина Е
    case vitaminE = "Vitamin E"
    /// Содержание витамина К
    case vitaminK = "Vitamin K"
    /// Содержание воды
    case water = "Water"
    /// Содержание цинка
    case zinc = "Zinc"
}
