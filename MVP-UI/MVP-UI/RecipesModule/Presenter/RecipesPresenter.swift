// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol RecipesProtocol: AnyObject {
    func tappedOnCell()
}

final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    weak var recipesCoordinator: RecipesCoordinator?

    init(view: UIViewController) {
        self.view = view
    }
}

extension RecipesPresenter: RecipesProtocol {
    func tappedOnCell() {
        recipesCoordinator?.pushDetailViewController()
    }
}
