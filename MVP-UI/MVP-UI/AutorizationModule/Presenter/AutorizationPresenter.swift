// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол авторизации
protocol AutorizationProtocol: AnyObject {
    /// Проверка логина
    func chekUser(login: String?)
    /// Проверка пароля
    func chekPassword(password: String?, login: String?)
}

/// Протокол авторизации вью
protocol AutorizationViewControllerProtocol: AnyObject {
    /// Меняем цвет тайтлу  при проверки валидности логина
    func setTitleColorLogin(color: String, isValidateLogin: Bool)
    /// Меняем цвет тайтлу  при проверки валидности пароля
    func setTitleColorPassword(color: String, isValidatePassword: Bool)
    /// Проверка юзера на валидность
    func chekValidateUser(imageButton: String?, titleButton: String?)
    /// Показать сплеш
    func showSpashScreenOn()
    /// Скрыть сплеш
    func showSpashScreenOff()
}

/// Презентер для экрана с авторизацией
final class AutorizationPresenter {
    private weak var view: AutorizationViewControllerProtocol?
    weak var autorizationCoordinator: AutorizationCoordinator?
    init(view: AutorizationViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - AutorizationProtocol

extension AutorizationPresenter: AutorizationProtocol {
    func chekPassword(password: String?, login: String?) {
        guard let login = login else { return }
        guard let password = password else { return }
        if password.count < 6 {
            view?.showSpashScreenOn()
            view?.setTitleColorPassword(color: "splashColor", isValidatePassword: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.view?.showSpashScreenOff()
            }
            return
        } else {
            view?.setTitleColorPassword(
                color: "splashColor",
                isValidatePassword: true
            )
        }
        view?.chekValidateUser(imageButton: "loader", titleButton: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.view?.chekValidateUser(imageButton: nil, titleButton: "Login")
            self.view?.showSpashScreenOff()
        }
    }

    func chekUser(login: String?) {
        guard let login = login else { return }
        if !login.hasSuffix("@"), !login.isEmpty {
            view?.setTitleColorLogin(color: "splashColor", isValidateLogin: false)
        } else {
            view?.setTitleColorLogin(color: "splashColor", isValidateLogin: true)
        }
    }
}
