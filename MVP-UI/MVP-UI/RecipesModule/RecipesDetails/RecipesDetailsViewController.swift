// RecipesDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера детального экрана
protocol DetailsViewInputProtocol: AnyObject {
    /// данные экрана рецептов
    func getDetail(recipe: RecipeDetail)
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

    private var recipe: RecipeDetail?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var rowsType: [RowsType] = [
        .header,
        .info,
        .description
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        makeTableView()
        detailsPresenter?.checkFavorite()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailsPresenter?.getDetail()
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
        tableView.register(ShimerHeaderViewCell.self, forCellReuseIdentifier: ShimerHeaderViewCell.identifier)
        tableView.register(ShimerDetailInfoViewCell.self, forCellReuseIdentifier: ShimerDetailInfoViewCell.identifier)
        tableView.register(ShimerDiscriptionViewCell.self, forCellReuseIdentifier: ShimerDiscriptionViewCell.identifier)
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
        if let recipeShare = recipe?.label, let logURL = FileManager.default.urls(
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
                .dequeueReusableCell(
                    withIdentifier: ShimerDetailInfoViewCell.identifier,
                    for: indexPath
                ) as? ShimerDetailInfoViewCell
            else { return UITableViewCell() }
//            guard let recipe = recipe else { return cell }
//            cell.configure(info: recipe)
            return cell

        case .info:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: ShimerHeaderViewCell.identifier,
                    for: indexPath
                ) as? ShimerHeaderViewCell
            else { return UITableViewCell() }
//            guard let recipe = recipe else { return cell }
//            cell.configure(info: recipe)
            return cell

        case .description:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: ShimerDiscriptionViewCell.identifier,
                    for: indexPath
                ) as? ShimerDiscriptionViewCell
            else { return UITableViewCell() }
            guard let recipe = recipe else { return cell }
            // cell.configure(info: recipe)
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

    func getDetail(recipe: RecipeDetail) {
        self.recipe = recipe
        tableView.reloadData()
    }
}
