// RecipesDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера детального экрана
protocol DetailsViewInputProtocol: AnyObject {
    /// данные экрана рецептов
    func getDetail(recipe: Recipe)
}

/// Экран рецепта
final class RecipesDetailsViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let heightCellHeader: CGFloat = 350
        static let heightCellInfo: CGFloat = 60
        static let heightCellDescription: CGFloat = 690
        static let titleAlert = "Функционал в разработке"
        static let confirmActionAlert = "Ok"
        static let titleArrowBackward = "arrowBackward"
        static let titleFavorites = "favorites"
        static let titleShared = "shared"
    }

    enum RowsType {
        case header
        case info
        case description
    }

    // MARK: - Public Properties

    var detailsPresenter: DetailsPresenter?

    // MARK: - Private Properties

    private var recipe: Recipe?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var rowsType: [RowsType] = [
        .header,
        .info,
        .description
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter?.getDetail()
        addSubview()
        makeTableView()
        makeBarButtonItem()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func makeTableView() {
        tableView.register(DetailsHeaderCell.self, forCellReuseIdentifier: DetailsHeaderCell.identifier)
        tableView.register(DetailsInfoCell.self, forCellReuseIdentifier: DetailsInfoCell.identifier)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    private func makeBarButtonItem() {
        let arrowButton = UIButton(type: .custom)
        arrowButton.setImage(UIImage(named: Constants.titleArrowBackward), for: .normal)
        arrowButton.addTarget(self, action: #selector(returnsAllRecipes), for: .touchUpInside)
        let arrowLogo = UIBarButtonItem(customView: arrowButton)
        let favoritesLogo = UIBarButtonItem(
            image: UIImage(named: Constants.titleFavorites),
            style: .plain,
            target: self,
            action: #selector(savesRecipeFavorites)
        )
        let shareLogo = UIBarButtonItem(
            image: UIImage(named: Constants.titleShared),
            style: .plain,
            target: self,
            action: #selector(method)
        )
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = arrowLogo
        navigationItem.rightBarButtonItems = [favoritesLogo, shareLogo]
        [arrowLogo, shareLogo, favoritesLogo].forEach { $0.tintColor = .black }
    }

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func returnsAllRecipes() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func savesRecipeFavorites() {
        let alert = UIAlertController(title: Constants.titleAlert, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.confirmActionAlert, style: .default, handler: nil)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}

// MARK: Extension + UITableViewDataSource

extension RecipesDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        rowsType.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = rowsType[indexPath.section]
        switch type {
        case .header:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: DetailsHeaderCell.identifier, for: indexPath) as? DetailsHeaderCell
            else { return UITableViewCell() }
            guard let recipe = recipe else { return cell }
            cell.configure(info: recipe)
            return cell

        case .info:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: DetailsInfoCell.identifier, for: indexPath) as? DetailsInfoCell
            else { return UITableViewCell() }
            guard let recipe = recipe else { return cell }
            cell.configure(info: recipe)
            return cell

        case .description:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as? DescriptionCell
            else { return UITableViewCell() }
            guard let recipe = recipe else { return cell }
            cell.configure(info: recipe)
            return cell
        }
    }
}

// MARK: Extension + UITableViewDelegate

extension RecipesDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sizeCell = rowsType[indexPath.section]
        switch sizeCell {
        case .header:
            return Constants.heightCellHeader
        case .info:
            return Constants.heightCellInfo
        case .description:
            return Constants.heightCellDescription
        }
    }
}

// MARK: Extension + DetailsViewInputProtocol

extension RecipesDetailsViewController: DetailsViewInputProtocol {
    func getDetail(recipe: Recipe) {
        self.recipe = recipe
    }
}
