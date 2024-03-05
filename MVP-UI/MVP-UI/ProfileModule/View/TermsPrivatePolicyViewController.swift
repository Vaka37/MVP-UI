// TermsPrivatePolicyViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран условий и политики конфиденциальности
class TermsPrivatePolicyViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static var fontVerdana = "Verdana"
        static var fontVerdanaBold = "Verdana-Bold"
        static var titleTermsOfUse = "Terms of Use"
        static var titlePrivatePolicy = "Welcome to our recipe app! We're thrilled to\n" +
            "have you on board. To ensure a delightful\n" +
            "experience for everyone, please take a moment to\n" +
            "familiarize yourself with our rules:\n" +
            "User Accounts:\n" +
            "Maintain one account per user.\n" +
            "Safeguard your login credentials; don't share them with others.\n" +
            "Content Usage:\n" +
            "Recipes and content are for personal use only.\n" +
            "Do not redistribute or republish recipes without proper attribution.\n" +
            "Respect Copyright:\n" +
            "Honor the copyright of recipe authors and contributors.\n" +
            "Credit the original source when adapting or modifying a recipe.\n" +
            "Community Guidelines:\n" +
            "Show respect in community features.\n" +
            "Avoid offensive language or content that violates community standards.\n" +
            "Feedback and Reviews:\n" +
            "Share constructive feedback and reviews.\n" +
            "Do not submit false or misleading information.\n" +
            "Data Privacy:\n" +
            "Review and understand our privacy policy regarding data collection and usage.\n" +
            "Compliance with Laws:\n" +
            "Use the app in compliance with all applicable laws and regulations.\n" +
            "Updates to Terms:\n" +
            "Stay informed about updates; we'll notify you of any changes.\n" +
            "By using our recipe app, you agree to adhere to these rules." +
            "Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!"
    }

    // MARK: - Visual Components

    private let dragHandleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .penHandle
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleTermsOfUse
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionPrivatePolicyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titlePrivatePolicy
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    private func addSubview() {
        view.addSubview(dragHandleImageView)
        view.addSubview(termsOfUseLabel)
        view.addSubview(descriptionPrivatePolicyLabel)
        view.addSubview(closeButton)
    }

    private func setupConstraints() {
        dragHandleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        dragHandleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        termsOfUseLabel.topAnchor.constraint(equalTo: dragHandleImageView.bottomAnchor, constant: 25).isActive = true
        termsOfUseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true

        descriptionPrivatePolicyLabel.topAnchor.constraint(equalTo: termsOfUseLabel.bottomAnchor, constant: 15)
            .isActive = true
        descriptionPrivatePolicyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
            .isActive = true
        descriptionPrivatePolicyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            .isActive = true

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    @objc private func closeViewController() {
        dismiss(animated: true)
    }
}
