// UiViewController + extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    /// расширение для скрытие клавиатурры по тапу
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
