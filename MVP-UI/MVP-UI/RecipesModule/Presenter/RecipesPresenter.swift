// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol RecipesProtocol: AnyObject {
    func tappedOnCell()
}

/// Презентер для рецептов
final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    weak var recipesCoordinator: RecipesCoordinator?

    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - extension + RecipesProtocol
extension RecipesPresenter: RecipesProtocol {
    func tappedOnCell() {
        recipesCoordinator?.pushDetailViewController()
    }
}
