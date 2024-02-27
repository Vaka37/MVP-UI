// UserProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol UserProfileProtocol: AnyObject {
    func presentViewController()
    func changeName()
}

final class UserProfilePresenter {
    weak var userCoordinator: UserProfileCoordinator?

    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

extension UserProfilePresenter: UserProfileProtocol {
    func presentViewController() {
        userCoordinator?.pushDetailViewController()
    }

    func changeName() {
        debugPrint("ChangeName")
    }
}
