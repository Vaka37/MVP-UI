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
    private var animator: UIViewPropertyAnimator?
//    private var userProfileViewController: UserProfileViewController?
    private var termsPrivatePolicyViewController: TermsPrivatePolicyViewController?

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
            let termsPrivatePolicyViewController = TermsPrivatePolicyViewController()
            let visualEffect = UIVisualEffectView()
            animator = UIViewPropertyAnimator(duration: 0.9, curve: .easeInOut, animations: { [weak self] in
                visualEffect.alpha = 0.5
            })
            if let propertyAnimator = animator, let view = termsPrivatePolicyViewController.view {
                animator = propertyAnimator
                self.view?.showTermsPrivacyPolicy(
                    withAnimator: propertyAnimator,
                    animatorEffect: visualEffect,
                    view: view,
                    termsPrivacyPolicyViewController: termsPrivatePolicyViewController
                )

                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
                panGesture.isEnabled = true
                panGesture.cancelsTouchesInView = false
            }
        default:
            break
        }
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: termsPrivatePolicyViewController?.view)
            let progress = translation.y / ((termsPrivatePolicyViewController?.view.bounds.height ?? 0) / 2)
            animator?.fractionComplete = min(max(progress, 0), 1)
        case .ended:
            let velocity = gesture.velocity(in: termsPrivatePolicyViewController?.view)
            if velocity.y > 0 {
                animator?.isReversed = true
            } else {
                animator?.isReversed = false
            }
            animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
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
