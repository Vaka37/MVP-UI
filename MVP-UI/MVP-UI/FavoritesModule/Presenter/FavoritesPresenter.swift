// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol FavoritesProtocol: AnyObject {
    func pushDetailFavoritesViewController()
}

/// Презентер для экрана с фаворитами
final class FavoritesPresenter {
    weak var favoritesCoordinator: FavoritesCoordinator?
    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - extension + FavoritesProtocol
extension FavoritesPresenter: FavoritesProtocol {
    func pushDetailFavoritesViewController() {
        debugPrint("pushDetailFavoritesViewController")
    }
}
