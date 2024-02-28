// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана профиля
protocol UserProfileViewInputProtocol: AnyObject {
    func showAlertChangeName()
    func updateTable(profileTable: [ProfileItem])
    func setTitleNameUser(name: String)
    func showBonusView()
}

/// Экран с информацией о пользователе
final class UserProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var titleNotices = "Profile"
        static var nameRegisterCell = "Cell"
    }

    // MARK: - Public Properties

    var presenter: UserProfilePresenterInputProtocol?

    // MARK: - Private Properties

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var rowsType: [ProfileItem]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        setupTableView()
        setupNavigation()
        setupTableView()

        presenter?.requestData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func setupNavigation() {
        navigationItem.title = Constants.titleNotices
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(NavigationTableViewCell.self, forCellReuseIdentifier: NavigationTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
    }

    private func setupConstraints() {
        setupTableViewConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85).isActive = true
    }
}

// MARK: - Подписываюсь на Data Source для таблицы

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        rowsType?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsType = rowsType?[section]
        switch rowsType {
        case .header:
            return 1
        case .navigation:
            return 3
        case .none:
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowsType = rowsType else { return UITableViewCell() }
        switch rowsType[indexPath.section] {
        case let .header(header):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell else { return UITableViewCell() }
            cell.configure(with: header)

            cell.editingButtonHandler = { [weak self] in
                self?.presenter?.setAlert()
            }
            return cell

        case let .navigation(navigation):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NavigationTableViewCell.identifier,
                for: indexPath
            ) as? NavigationTableViewCell else { return UITableViewCell() }
            cell.configure(with: navigation[indexPath.row])
            return cell
        }
    }
}

// MARK: - Подписываюсь на Delegate для таблицы

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = rowsType?[indexPath.section] else { return 0 }
        switch cell {
        case .header:
            return 250
        case .navigation:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rowsType?[indexPath.section]
        switch item {
        case .header:
            break
        case .navigation:
            presenter?.tapSelectItem(index: indexPath.row)
        case .none:
            break
        }
    }
}

// MARK: - Подписываюконтроллер на протокол

extension UserProfileViewController: UserProfileViewInputProtocol {
    func showBonusView() {
        let bonusViewController = BonusViewController()
        if let sheetPresentationController = bonusViewController.sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = 30
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
        }
        present(bonusViewController, animated: true, completion: nil)
    }

    func setTitleNameUser(name: String) {
        guard var currentRowsType = rowsType else { return }

        if let headerIndex = currentRowsType.firstIndex(where: { item in
            if case .header = item {
                return true
            } else {
                return false
            }
        }) {
            if case var .header(data) = currentRowsType[headerIndex] {
                data.userName = name
                currentRowsType[headerIndex] = .header(data)
                rowsType = currentRowsType
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    func showAlertChangeName() {
        let alert = UIAlertController(title: "Change your name and surname", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if let text = alert.textFields?[0].text {
                self.presenter?.updateUserName(withName: text)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField { textField in
            textField.placeholder = "Name Surname"
        }

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    func updateTable(profileTable: [ProfileItem]) {
        rowsType = profileTable
        tableView.reloadData()
    }
}
