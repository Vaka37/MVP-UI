// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Составляющие категории
struct Category {
    /// Аватар категории
    var avatarImageName: String
    /// Название категории
    var categoryTitle: String
    /// сетка категорий
    var categoryType: CategoryType
    /// размер ячейки
    var sizeCell: SizeCellCategory
    /// Рецепты
    var recepies: [Recipie]
}
