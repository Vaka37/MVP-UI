// RecipiesViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка категорий рецептов
final class RecipiesViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 18
        static let fontVerdana = "Verdana"
    }

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(RecipiesViewCell.self)
    var categoryPushHandler: VoidHandler?

    // MARK: - Private Properties

    private var modelCategory: Category?
    var categoryLayer: CAGradientLayer?

    // MARK: - Visual Components

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
        label.backgroundColor = .backgroundNameCategory
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
        super.init(coder: coder)
        createContentView()
        addSubview()
        setupConstraints()
        print(categoryLayer, "State Handler Cell")
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        categoryLayer?.cornerRadius = 18
//        categoryLayer?.frame = contentView.bounds
//        categoryLayer?.colors = [UIColor.systemGray3.cgColor, UIColor.white.cgColor]
//        categoryLayer?.startPoint = CGPoint(x: 0, y: 0.5)
//        categoryLayer?.endPoint = CGPoint(x: 1, y: 0.5)
//        categoryButton.layer.addSublayer(categoryLayer ?? CAGradientLayer())
//        contentView.layer.addSublayer(categoryLayer ?? CAGradientLayer())
//    }

    // MARK: - Public Methods

    func configure(model: Category, categoryLayer: CAGradientLayer) {
        self.categoryLayer = categoryLayer
        let image = UIImage(named: model.avatarImageName)
        categoryButton.setImage(image, for: .normal)
        nameCategoryLabel.text = model.categoryTitle

        self.categoryLayer?.cornerRadius = 18
        self.categoryLayer?.frame = contentView.frame
        self.categoryLayer?.colors = [UIColor.systemGray3.cgColor, UIColor.white.cgColor]
        self.categoryLayer?.startPoint = CGPoint(x: 0, y: 0.5)
        self.categoryLayer?.endPoint = CGPoint(x: 1, y: 0.5)
        contentView.layer.addSublayer(self.categoryLayer ?? CAGradientLayer())
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
        categoryPushHandler?()
    }
}
