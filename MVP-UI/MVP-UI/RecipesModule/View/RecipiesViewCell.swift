// RecipiesViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка категорий рецептов
class RecipiesViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 18
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(RecipiesViewCell.self)

    // MARK: - Private Properties

    private var modelCategory: Category?
    private var categoryPushHandler: ((_ categoryType: CategoryType) -> ())?

    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(pushCategory), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = modelCategory?.categoryTitle
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.5816243291, green: 0.5965673327, blue: 0.6049087644, alpha: 0.6044857202)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.font = UIFont(name: Constants.fontVerdana, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        createContentView()
        addSubview()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: Category, handler: ((_ categoryType: CategoryType) -> ())?) {
        let image = UIImage(named: model.avatarImageName)
        categoryButton.setImage(image, for: .normal)
        nameCategoryLabel.text = model.categoryTitle
    }

    // MARK: - Private Methods

    private func createContentView() {
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 5, height: 6)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.4
    }

    private func addSubview() {
        contentView.addSubview(categoryButton)
        categoryButton.addSubview(nameCategoryLabel)
    }

    private func setupConstraints() {
        setupCategoryButtonConstraints()
        setupNameCategoryConstraints()
    }

    private func setupCategoryButtonConstraints() {
        categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        categoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupNameCategoryConstraints() {
        nameCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameCategoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameCategoryLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5).isActive = true
    }

    @objc private func pushCategory() {
        categoryPushHandler?(modelCategory?.categoryType ?? .fish)
    }
}
