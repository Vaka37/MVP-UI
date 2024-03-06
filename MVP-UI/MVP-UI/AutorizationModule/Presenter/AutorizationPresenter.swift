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
    // MARK: - Constants

    private enum Constants {
        static let color = "splashColor"
        static let loader = "loader"
        static let login = "Login"
        static let suffix = "@"
        static let timer: CGFloat = 3
        static let value = 6
    }

    private weak var view: AutorizationViewControllerProtocol?
    private weak var autorizationCoordinator: AutorizationCoordinator?
    init(view: AutorizationViewControllerProtocol, coordinator: AutorizationCoordinator) {
        self.view = view
        autorizationCoordinator = coordinator
    }

    private func goToMainTabBarScreen() {
        autorizationCoordinator?.showMainViewController()
    }
}

// MARK: - AutorizationProtocol

extension AutorizationPresenter: AutorizationProtocol {
    func chekPassword(password: String?, login: String?) {
        guard let login = login else { return }
        guard let password = password else { return }
        if password.count < Constants.value {
            goToMainTabBarScreen()
            // Здесь идет проверка пароля на валидность
//            view?.showSpashScreenOn()
//            view?.setTitleColorPassword(color: "splashColor", isValidatePassword: false)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.view?.showSpashScreenOff()
//            }
            return
        } else {
            view?.setTitleColorPassword(
                color: Constants.color,
                isValidatePassword: true
            )
        }
        view?.chekValidateUser(imageButton: Constants.loader, titleButton: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timer) {
            self.view?.chekValidateUser(imageButton: nil, titleButton: Constants.login)
            self.view?.showSpashScreenOff()
        }
    }

    func chekUser(login: String?) {
        guard let login = login else { return }
        if !login.hasSuffix(Constants.suffix), !login.isEmpty {
            view?.setTitleColorLogin(color: Constants.color, isValidateLogin: false)
        } else {
            view?.setTitleColorLogin(color: Constants.color, isValidateLogin: true)
        }
    }
}
