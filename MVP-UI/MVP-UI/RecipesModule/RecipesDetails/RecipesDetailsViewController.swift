// RecipesDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера детального экрана
protocol DetailsViewInputProtocol: AnyObject {
    /// данные экрана рецептов
    func getDetail(recipe: Recipe)
    /// метод приисутсвия  рецепта в  избранным
    func isFavorite()
    /// метод отсутсвия  рецепта в  избранным
    func noFavorite()
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
        static let titleNoFavorites = "noFavorite"
        static let titleShared = "shared"
        static let isFavorite = "isFavorite"
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
        detailsPresenter?.checkFavorite()
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

    private func makeBarButtonItem(image: String, tintColor: UIColor) {
        let arrowButton = UIButton(type: .custom)
        arrowButton.setImage(UIImage(named: Constants.titleArrowBackward), for: .normal)
        arrowButton.addTarget(self, action: #selector(returnsAllRecipes), for: .touchUpInside)
        let arrowLogo = UIBarButtonItem(customView: arrowButton)
        let favoritesLogo = UIBarButtonItem(
            image: UIImage(named: image),
            style: .plain,
            target: self,
            action: #selector(savesRecipeFavorites)
        )
        let shareLogo = UIBarButtonItem(
            image: UIImage(named: Constants.titleShared),
            style: .plain,
            target: self,
            action: #selector(sharedRecipe)
        )
        favoritesLogo.tintColor = tintColor
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = arrowLogo
        navigationItem.rightBarButtonItems = [favoritesLogo, shareLogo]
        [arrowLogo, shareLogo].forEach { $0.tintColor = .black }
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
        detailsPresenter?.changeFavorites()
    }

    @objc private func sharedRecipe() {
        if let recipeShare = recipe?.titleRecipies, let logURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("log.txt") {
            let logAction = LogAction.userSharedRecipe(recipeShare)
            logAction.log(fileURL: logURL)
            do {
                let logContent = try String(contentsOf: logURL)
            } catch {}
        } else {}
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
    func noFavorite() {
        makeBarButtonItem(image: Constants.titleNoFavorites, tintColor: .black)
        tableView.reloadData()
    }

    func isFavorite() {
        makeBarButtonItem(image: Constants.isFavorite, tintColor: .red)
        tableView.reloadData()
    }

    func getDetail(recipe: Recipe) {
        self.recipe = recipe
    }
}
