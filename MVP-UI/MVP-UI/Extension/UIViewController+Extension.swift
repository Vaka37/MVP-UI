// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    /// Расширение для скрытие клавиатуры по тапу
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
