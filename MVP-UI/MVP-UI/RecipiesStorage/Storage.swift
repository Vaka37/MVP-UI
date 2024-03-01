// Storage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Моковые данные
final class Storage {
    // MARK: - Public Properties

    var fish: [Recipie] = [
        Recipie(
            avatarRecipie: "fish1",
            titleRecipies: "Simple Fish And Corn",
            cookingTimeTitle: "60",
            caloriesTitle: "274",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ),
            recipeDescriptionTitle: "1/2 to 2 fish heads, depending on size, about 5 pounds total 2 tablespoons"
        ),
        Recipie(
            avatarRecipie: "fish2",
            titleRecipies: "Baked Fish with Lemon Herb Sauce",
            cookingTimeTitle: "90",
            caloriesTitle: "616",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ), recipeDescriptionTitle: ""
        ),
        Recipie(
            avatarRecipie: "fish3",
            titleRecipies: "Lemon and Chilli Fish Burrito",
            cookingTimeTitle: "90",
            caloriesTitle: "226",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ), recipeDescriptionTitle: ""
        ),
        Recipie(
            avatarRecipie: "fish4",
            titleRecipies: "Fast Roast Fish & Show Peas Recipes",
            cookingTimeTitle: "80",
            caloriesTitle: "94",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ), recipeDescriptionTitle: ""
        ),
        Recipie(
            avatarRecipie: "fish5",
            titleRecipies: "Salmon with Cantaloupe and Fried Shallots",
            cookingTimeTitle: "100",
            caloriesTitle: "410",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ), recipeDescriptionTitle: ""
        ),
        Recipie(
            avatarRecipie: "fish6",
            titleRecipies: "Chilli and Tomato Fish",
            cookingTimeTitle: "100",
            caloriesTitle: "174",
            nutrientsTitle: NutrientsFields(
                nutrientName: NutrientsNames(
                    calories: "Enerc kcal",
                    carbohydrates: "Carbohydrates",
                    fats: "Fats",
                    proteins: "Proteins"
                ),
                significance: NutrientsValues(
                    energyKcal: "1322 kcal",
                    carbohydrates: "10,78 g",
                    fats: "10,00 g",
                    proteins: "97,30 g"
                )
            ), recipeDescriptionTitle: ""
        )
    ]

    lazy var category: [Category] = [
        .init(avatarImageName: "salad", categoryTitle: "Salad", sizeCell: .medium, recepies: []),
        .init(avatarImageName: "soup", categoryTitle: "Soup", sizeCell: .medium, recepies: []),
        .init(
            avatarImageName: "chicken",
            categoryTitle: "Chicken",
            sizeCell: .big,
            recepies: []
        ),
        .init(avatarImageName: "meat", categoryTitle: "Meat", sizeCell: .small, recepies: []),
        .init(avatarImageName: "fish", categoryTitle: "Fish", sizeCell: .small, recepies: fish),
        .init(
            avatarImageName: "side dish",
            categoryTitle: "Side dish",
            sizeCell: .small,
            recepies: []
        ),
        .init(avatarImageName: "drinks", categoryTitle: "Drinks", sizeCell: .big, recepies: []),
        .init(
            avatarImageName: "pancakes",
            categoryTitle: "Pancake",
            sizeCell: .medium,
            recepies: []
        ),
        .init(
            avatarImageName: "desserts",
            categoryTitle: "Desserts",
            sizeCell: .medium,
            recepies: []
        )
    ]
}
