// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол которому доллжен соответссвовать модель юзера
protocol MementoUser: Codable, Encodable {
    /// емаил
    var emailTitle: String { get }
    /// пароль
    var passwordTitle: String { get }
    /// Логин пользователя
    var login: String { get }
    /// Аватар
    var avatar: String? { get }
}

/// Пользователь
struct User: MementoUser {
    var login: String
    var emailTitle: String
    var passwordTitle: String
    var avatar: String?
}
