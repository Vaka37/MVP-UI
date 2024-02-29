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
            caloriesTitle: "274"
        ),
        Recipie(
            avatarRecipie: "fish2",
            titleRecipies: "Baked Fish with Lemon Herb Sauce",
            cookingTimeTitle: "90",
            caloriesTitle: "616"
        ),
        Recipie(
            avatarRecipie: "fish3",
            titleRecipies: "Lemon and Chilli Fish Burrito",
            cookingTimeTitle: "90",
            caloriesTitle: "226"
        ),
        Recipie(
            avatarRecipie: "fish4",
            titleRecipies: "Fast Roast Fish & Show Peas Recipes",
            cookingTimeTitle: "80",
            caloriesTitle: "94"
        ),
        Recipie(
            avatarRecipie: "fish5",
            titleRecipies: "Salmon with Cantaloupe and Fried Shallots",
            cookingTimeTitle: "100",
            caloriesTitle: "410"
        ),
        Recipie(
            avatarRecipie: "fish6",
            titleRecipies: "Chilli and Tomato Fish",
            cookingTimeTitle: "100",
            caloriesTitle: "174"
        )
    ]

    lazy var category: [Category] = [
        .init(avatarImageName: "salad", categoryTitle: "Salad", recepies: []),
        .init(avatarImageName: "soup", categoryTitle: "Soup", recepies: []),
        .init(avatarImageName: "chicken", categoryTitle: "Chicken", recepies: []),
        .init(avatarImageName: "meat", categoryTitle: "Meat", recepies: []),
        .init(avatarImageName: "fish", categoryTitle: "Fish", recepies: fish),
        .init(avatarImageName: "side dish", categoryTitle: "Side dish", recepies: []),
        .init(avatarImageName: "drinks", categoryTitle: "Drinks", recepies: []),
        .init(avatarImageName: "pancake", categoryTitle: "Pancake", recepies: []),
        .init(avatarImageName: "desserts", categoryTitle: "Desserts", recepies: [])
    ]
}
