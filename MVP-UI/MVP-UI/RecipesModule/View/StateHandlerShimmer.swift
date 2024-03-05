// StateHandlerShimmer.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Варианты состояния таблицы
enum ShimmerState {
    case loading
    case loaded
}

/// Конкретное состояние
final class StateHandlerShimmer {
//    private var state: ShimmerState?
    private var recipesViewController: RecipesViewController?
    private var categoryLayer: CAGradientLayer

    init(categoryLayer: CAGradientLayer, recipesViewController: RecipesViewController) {
        self.categoryLayer = categoryLayer
        self.recipesViewController = recipesViewController
    }

    func setState(newState: ShimmerState) {
        switch newState {
        case .loading:
            showShimmer()
        case .loaded:
            showData()
        }
    }

    private func showShimmer() {
        let animationDuration: CFTimeInterval = 2
        let animation = CABasicAnimation(keyPath: "colors")
        print(categoryLayer, "State Handler Shimmer")

        animation.fromValue = [UIColor.red.cgColor, UIColor.white.cgColor]
        animation.toValue = [UIColor.white.cgColor, UIColor.red.cgColor]
        animation.beginTime = 0
        animation.duration = animationDuration
        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
        animation.autoreverses = true

//        let group = CAAnimationGroup()
//        group.animations = [animation]
//        group.duration = animationDuration
//        group.fillMode = .forwards
//        group.isRemovedOnCompletion = false
//        group.repeatCount = .infinity

        categoryLayer.add(animation, forKey: "shimmer")
//        recipesViewController?.collectionView.reloadData()
    }

    private func showData() {}
}
