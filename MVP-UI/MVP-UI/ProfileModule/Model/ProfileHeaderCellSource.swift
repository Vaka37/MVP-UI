// ProfileHeaderCellSource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник данных ячейки шапки профиля
struct ProfileHeaderCellSource {
    /// Аватарка пользователя
    let avatarImageName: String
    /// Имя пользователя
    var userName: String

    // MARK: - Public Methods

    static func getProfileHeader() -> ProfileHeaderCellSource {
        ProfileHeaderCellSource(avatarImageName: "imageProfile", userName: "Name Surname")
    }
}
