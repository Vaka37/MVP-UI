// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Составляющие категории
struct Category {
    /// Аватар
    var avatarImageName: String
    /// Название
    var categoryTitle: String
    /// размер ячейки
    var sizeCell: SizeCellCategory
    /// Рецепты
    var recepies: [Recipe]
}
