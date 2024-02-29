// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана профиля
protocol UserProfileViewInputProtocol: AnyObject {
    /// Метод для вызова алерта
    func showAlertChangeName()
    /// Метод для обновления таблицы
    func updateTable(profileTable: [ProfileItem])
    /// Метод для установки имени юзера
    func setTitleNameUser(name: String)
    ///  Метод для показа бонус-контролерра
    func showBonusView()
}

/// Экран с информацией о пользователе
final class UserProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleNotices = "Profile"
        static let nameRegisterCell = "Cell"
        static let alertTitle = "Change your name and surname"
        static let cancelAlertButton = "Cancel"
        static let placeholderAlert = "Name Surname"
        static let doneButton = "Ok"
    }

    // MARK: - Visual Components

    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Public Properties

    var presenter: UserProfilePresenterInputProtocol?

    // MARK: - Private Properties

    private var rowTypes: [ProfileItem]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        makeTableView()
        makeNavigation()
        makeTableView()
        presenter?.requestUser()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func makeNavigation() {
        navigationItem.title = Constants.titleNotices
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func makeTableView() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(NavigationTableViewCell.self, forCellReuseIdentifier: NavigationTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func setupConstraints() {
        setupTableViewConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Подписываюсь на Data Source для таблицы

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        rowTypes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsType = rowTypes?[section]
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
        guard let rowsType = rowTypes else { return UITableViewCell() }
        switch rowsType[indexPath.section] {
        case let .header(header):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell else { return UITableViewCell() }
            cell.configure(with: header)

            cell.editingButtonHandler = { [weak self] in
                self?.presenter?.actionAlert()
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
        guard let cell = rowTypes?[indexPath.section] else { return 0 }
        switch cell {
        case .header:
            return 250
        case .navigation:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rowTypes?[indexPath.section]
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
        guard var currentRowsType = rowTypes else { return }

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
                rowTypes = currentRowsType
                tableView.reloadData()
            }
        }
    }

    func showAlertChangeName() {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.doneButton, style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.presenter?.updateUserName(withName: text)
            }
        }

        let cancelAction = UIAlertAction(title: Constants.cancelAlertButton, style: .default)
        alert.addTextField { textField in
            textField.placeholder = Constants.placeholderAlert
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    func updateTable(profileTable: [ProfileItem]) {
        rowTypes = profileTable
        tableView.reloadData()
    }
}
