// UserProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера
protocol UserProfilePresenterInputProtocol: AnyObject {
    /// Метод для тапа по ячейке
    func tapSelectItem(index: Int)
    /// Запрос пользователя
    func requestUser()
    /// Метод дляя обновления информации о пользователе
    func updateUserName(withName name: String)
    ///  Метод для экшена по кнопке
    func actionAlert()
}

/// Презентер экрана профиля
final class UserProfilePresenter {
    private weak var userCoordinator: UserProfileCoordinator?
    private weak var view: UserProfileViewInputProtocol?
    private var user: ProfileHeaderCellSource?

    init(view: UserProfileViewInputProtocol?, userCoordinator: UserProfileCoordinator) {
        self.view = view
        self.userCoordinator = userCoordinator
    }
}

// MARK: - extension + UserProfileProtocol

extension UserProfilePresenter: UserProfilePresenterInputProtocol {
    func actionAlert() {
        view?.showAlertChangeName()
    }

    func updateUserName(withName name: String) {
        user?.userName = name
        view?.setTitleNameUser(name: name)
    }

    func tapSelectItem(index: Int) {
        switch index {
        case 0:
            view?.showBonusView()
        case 1:
            view?.showTermsPrivacyPolicy()
        default:
            break
        }
    }

    func requestUser() {
        let dataHeader = ProfileHeaderCellSource.getProfileHeader()
        let dataNavigation = ProfileNavigationCellSource.getProfileNavigation()
        let rowsType: [ProfileItem] = [
            .header(dataHeader),
            .navigation(dataNavigation)
        ]
        view?.updateTable(profileTable: rowsType)
    }

    func presentViewController() {
        userCoordinator?.pushDetailViewController()
    }
}
