// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана категорий
protocol CategoryViewInputProtocol: AnyObject {
    /// Метод для обновления таблицы
    func updateData(category: [String])
}

/// Экран с рецептами
class RecipesViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleRecipesItem = "Recipes"
    }

    var presenter: RecipesPresenter?

    // MARK: - Public Properties

    var storage = Storage()

    // MARK: - Private Properties

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        makeCollectionView()
        makeNavigationBar()

        presenter?.requestDataCategory()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.addSubview(collectionView)
    }

    private func makeCollectionView() {
        collectionView.register(RecipiesViewCell.self, forCellWithReuseIdentifier: RecipiesViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func makeNavigationBar() {
        title = Constants.titleRecipesItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Подписываюсь на Data Source для коллекции

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storage.category.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipiesViewCell.identifier,
            for: indexPath
        ) as? RecipiesViewCell else { return UICollectionViewCell() }
        cell.configure(model: storage.category[indexPath.item]) { categoryType in
            self.presenter?.tappedOnCell(type: categoryType)
        }
        return cell
    }
}

// MARK: - Подписываюсь на Delegate для коллекции

extension RecipesViewController: UICollectionViewDelegate {}

// MARK: - Подписываюсь на Delegate Layout для коллекции

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = storage.category[indexPath.item].sizeCell
        switch size {
        case .small:
            let small = CGSize(
                width: (UIScreen.main.bounds.width - 40) / 3,
                height: (UIScreen.main.bounds.width - 40) / 3
            )
            return small
        case .medium:
            let medium = CGSize(
                width: (UIScreen.main.bounds.width - 30) / 2,
                height: (UIScreen.main.bounds.width - 30) / 2
            )
            return medium
        case .big:
            let big = CGSize(width: 250, height: 250)
            return big
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        15
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    private func getCategoryForIndexPath(_ indexPath: IndexPath) -> CategoryType {
        switch indexPath.section {
        case 0:
            return .salad
        case 1:
            return .soup
        case 2:
            return .chicken
        case 3:
            return .meat
        case 4:
            return .fish
        case 5:
            return .sideDish
        case 6:
            return .drinks
        case 7:
            return .pancake
        case 8:
            return .desserts
        default:
            return .fish
        }
    }

    private func sizeForCategory(_ category: CategoryType) -> CGSize {
        switch category {
        case .salad:
            return CGSize(width: 175, height: 175)
        case .soup:
            return CGSize(width: 175, height: 175)
        case .chicken:
            return CGSize(width: 250, height: 250)
        case .meat:
            return CGSize(width: 110, height: 110)
        case .fish:
            return CGSize(width: 110, height: 110)
        case .sideDish:
            return CGSize(width: 110, height: 110)
        case .drinks:
            return CGSize(width: 250, height: 250)
        case .pancake:
            return CGSize(width: 175, height: 175)
        case .desserts:
            return CGSize(width: 175, height: 175)
        }
    }
}

extension RecipesViewController: CategoryViewInputProtocol {
    func updateData(category: [String]) {
//        self.category = category.map { Category(
//            avatarImageName: "",
//            categoryTitle: $0,
//            categoryType: .fish,
//            recepies: []
//        ) }
//        collectionView.reloadData()
    }
}
