// ShimerCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ShimerCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let valueCornerRadius: CGFloat = 18
        static let gradientKey = "shimerCell"
    }

    // MARK: - Public Properties

    static let identifier = NSStringFromClass(ShimerCollectionViewCell.self)

    // MARK: - Private Properties

    private var modelCategory: Category?
    var categoryLayer: CAGradientLayer?

    // MARK: - Visual Components

    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.valueCornerRadius
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .backgroundNameCategory
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupConstraints()
    }

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradient()
    }

    // MARK: - Private Methods

    private func addGradient() {
        let gradientBackground = CAGradientLayer()
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = contentView.bounds
        gradientBackground.cornerRadius = 12
        categoryButton.layer.addSublayer(gradientBackground)

        let viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)

        let gradientTitle = CAGradientLayer()
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = nameCategoryLabel.frame
        nameCategoryLabel.layer.addSublayer(gradientTitle)

        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)
    }

    private func makeAnimation(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5

        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation.fromValue = UIColor.lightGray.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = animDuration
        animation.beginTime = 0.0

        let animation2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation2.fromValue = UIColor.white.cgColor
        animation2.toValue = UIColor.lightGray.cgColor
        animation2.duration = animDuration
        animation2.beginTime = animation.beginTime + animation2.duration

        let group = CAAnimationGroup()
        group.animations = [animation, animation2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = animation2.beginTime + animation.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        return group
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
}
