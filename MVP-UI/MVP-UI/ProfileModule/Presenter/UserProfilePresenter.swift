// UserProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера
protocol UserProfilePresenterInputProtocol: AnyObject {
    func tapSelectItem(index: Int)

    func requestData()
    func updateUserName(withName name: String)
    func setAlert()
}

/// Презентер экрана профиля
final class UserProfilePresenter {
    weak var userCoordinator: UserProfileCoordinator?
    weak var view: UserProfileViewInputProtocol?
    var user: ProfileHeaderCellSource?

    init(view: UserProfileViewInputProtocol?) {
        self.view = view
    }
}

// MARK: - extension + UserProfileProtocol

extension UserProfilePresenter: UserProfilePresenterInputProtocol {
    func setAlert() {
        view?.showAlertChangeName()
    }

    func updateUserName(withName name: String) {
        user?.userName = name
        view?.setTitleNameUser(name: name)
    }

    func tapSelectItem(index: Int) {
        print(index)
        guard index == 0 else { return }
        view?.showBonusView()
    }

    func requestData() {
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
