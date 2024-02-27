// TabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер
final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "selectedIconTabBar")
    }
}
