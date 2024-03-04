// RecipesListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Табличное предсставлене с рецептами
final class RecipesListViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let backBarButtonImage = UIImage(systemName: "arrow.backward")
        static let filterIconImage = UIImage(named: "filterIcon")
        static let titleNavigation = "Fish"
        static let serchPlaceholder = "Search recipes"
        static let caloriesButtonTitle = "Calories"
        static let timeButtonTitle = "Time"
    }

    // MARK: - Visual Components

    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.showsVerticalScrollIndicator = false
        return table
    }()

    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        return search
    }()

    let caloriesButton = UIButton()
    let timeButton = UIButton()

    // MARK: - Public Properties

    var recipePresenter: RecipePresenter?

    // MARK: - Private Properties

    private var recipes: Category?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        recipePresenter?.getUser()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
//        addTapGestureToHideKeyboard()
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(recipesTableView)
        makeFilterButton(button: caloriesButton, title: Constants.caloriesButtonTitle)
        makeFilterButton(button: timeButton, title: Constants.timeButtonTitle)
        configureNavigation()
        makeAnchor()
    }

    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .black
        let customButton = UIButton(type: .custom)
        customButton.setImage(Constants.backBarButtonImage, for: .normal)
        if let buttonTitle = recipes?.categoryTitle {
            customButton.setTitle("  \(buttonTitle)", for: .normal)
        }
        customButton.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        customButton.setTitleColor(.black, for: .normal)
        let customBarButtonItem = UIBarButtonItem(customView: customButton)
        navigationItem.leftBarButtonItem = customBarButtonItem
        tabBarController?.tabBar.isHidden = true
    }

    private func makeFilterButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setImage(Constants.filterIconImage, for: .normal)
        button.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        timeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
        caloriesButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    private func makeAnchor() {
        makeAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
        makeTableViewAnchor()
    }

    @objc private func timeButtonTapped(seder: UIButton) {
        seder.backgroundColor = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1.0)
        seder.setTitleColor(.white, for: .normal)
        seder.imageView?.transform = seder.imageView?.transform.rotated(by: .pi) ?? CGAffineTransform()
        seder.setTitleColor(.black, for: .normal)
    }

    @objc private func dissmiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension + Layout

extension RecipesListViewController {
    private func makeAnchorsSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 335).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func makeTableViewAnchor() {
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        recipesTableView.topAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 10).isActive = true
        recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupAnchorsCaloriesButton() {
        caloriesButton.translatesAutoresizingMaskIntoConstraints = false
        caloriesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        caloriesButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        caloriesButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
        caloriesButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupAnchorsTimeButton() {
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.leadingAnchor.constraint(equalTo: caloriesButton.trailingAnchor, constant: 11).isActive = true
        timeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        timeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
}

// MARK: - Extension + UITableViewDelegate

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = recipes?.recepies[indexPath.row] else { return }
        recipePresenter?.tappedOnCell(recipe: recipe)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}

// MARK: - Extension + UITableViewDataSource

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes?.recepies.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdendefire,
            for: indexPath
        ) as? RecipesCell
        else { return UITableViewCell() }
        guard let recipe = recipes?.recepies[indexPath.row] else { return cell }
        cell.configure(with: recipe)
        return cell
    }
}

// MARK: - Extension + RecipesViewProtocol

extension RecipesListViewController: RecipesViewProtocol {
    func getRecipes(recipes: Category) {
        self.recipes = recipes
        recipesTableView.reloadData()
    }
}
