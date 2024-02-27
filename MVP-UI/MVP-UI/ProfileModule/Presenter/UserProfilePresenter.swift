// UserProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol UserProfileProtocol: AnyObject {
    func presentViewController()
    func changeName()
}

/// Презентер для экрана с профилем
final class UserProfilePresenter {
    weak var userCoordinator: UserProfileCoordinator?

    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - extension + UserProfileProtocol

extension UserProfilePresenter: UserProfileProtocol {
    func presentViewController() {
        userCoordinator?.pushDetailViewController()
    }

    func changeName() {
        debugPrint("ChangeName")
    }
}
