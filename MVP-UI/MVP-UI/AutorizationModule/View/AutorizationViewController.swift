// AutorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с авторизацией пользователя
final class AutorizationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Login"
        static let titleColor = UIColor(named: "сolorIconTabBar")
        static let topGradientColor = UIColor.white.cgColor
        static let bottomGradientColor = UIColor(named: "bottomGradientColor")?.cgColor
        static let loginTitle = "Email Address"
        static let passwordTitle = "Password"
        static let loginPlaceholderTitle = "Enter Email Address"
        static let passwordPlaceholderTitle = "Enter Password"
        static let leftLoginIcon = UIImage.mailIcon
        static let leftPasswordIcon = UIImage.passwordIcon
        static let loginButtonColor = UIColor(named: "logInButtonColor")
        static let splashViewColor = UIColor(named: "splashColor")
        static let errorValidLoginText = "Incorrect format"
        static let errorPasswordLoginText = "You entered the wrong password"
        static let spllashTitle = "Please check the accuracy of the entered credentials."
    }

    // MARK: - Visual Components

    private let loginTitleLabel = UILabel()
    private let passwordLabel = UILabel()
    private let loginTextField = UITextField()
    private let errorLoginLabel = UILabel()
    private let errorPasswordLabel = UILabel()
    private let passwordTextField = UITextField()
    private lazy var chekButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.loginButtonColor
        button.tintColor = .white
        button.setTitle(Constants.title, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()

    private let splashView: UIView = {
        let splash = UIView()
        splash.layer.cornerRadius = 12
        splash.backgroundColor = Constants.splashViewColor
        return splash
    }()

    private let splashTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.text = Constants.spllashTitle
        return label
    }()

    // MARK: - Public Properties

    var autorizationPresenter: AutorizationPresenter?

    // MARK: - Private Properties

    private var countKeyboardTap = 0
    private var chekButtonLineY: CGFloat = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        addTapGestureToHideKeyboard()
        view.backgroundColor = .white
        title = Constants.title
        navigationController?.navigationBar
            .largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: Constants.titleColor ?? UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [Constants.topGradientColor, Constants.bottomGradientColor ?? UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func configureUI() {
        makeGradient()
        makeLabel(label: loginTitleLabel, title: Constants.loginTitle)
        makeLabel(label: passwordLabel, title: Constants.passwordTitle)
        makeTextFields(
            textField: loginTextField,
            placeholder: Constants.loginPlaceholderTitle,
            leftIcon: Constants.leftLoginIcon
        )
        makeTextFields(
            textField: passwordTextField,
            placeholder: Constants.passwordPlaceholderTitle,
            leftIcon: Constants.leftPasswordIcon
        )
        makeErrorLabel(label: errorLoginLabel, title: Constants.errorValidLoginText)
        makeErrorLabel(label: errorPasswordLabel, title: Constants.errorPasswordLoginText)
        view.addSubview(chekButton)
        view.addSubview(splashView)
        splashView.addSubview(splashTitleLabel)
        makeAnchor()
        observbleKeyboard()
    }

    private func makeLabel(label: UILabel, title: String) {
        label.text = title
        label.textColor = Constants.titleColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
    }

    private func makeTextFields(textField: UITextField, placeholder: String, leftIcon: UIImage) {
        textField.placeholder = placeholder
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.delegate = self
        textField.layer.borderColor = Constants.titleColor?.withAlphaComponent(0.14).cgColor
        let leftView = UIView()
        let imageView = UIImageView()
        leftView.addSubview(imageView)
        leftView.frame.size = CGSize(width: 30, height: 30)
        imageView.frame.size = CGSize(width: 18, height: 18)
        imageView.center = leftView.center
        imageView.image = leftIcon
        textField.leftView = leftView
        textField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        view.addSubview(textField)
    }

    private func makeErrorLabel(label: UILabel, title: String) {
        label.textColor = .red
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        view.addSubview(label)
    }

    private func makeAnchor() {
        makeLoginLabelAnchor()
        makePasswordLabelAnchor()
        makeLoginTexFieldAnchor()
        makePasswordTexFieldAnchor()
        makePasswordTexFieldAnchor()
        makeChekButtonAnchor()
        makeErrorLabelAnchor()
        makeErrorLabelPasswordAnchor()
        makeSplashAnchor()
        makeSplashTitleAnchor()
    }

    private func observbleKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keybordWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keybordWillShow(notiffication: NSNotification) {
        if countKeyboardTap == 1 { return }
        chekButtonLineY = chekButton.frame.origin.y
        countKeyboardTap += 1
        guard let keyboardFrame = notiffication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        let keyboardHeight = keyboardFrame.height
        chekButton.translatesAutoresizingMaskIntoConstraints = true
        chekButton.frame.origin.y -= keyboardHeight - chekButton.frame.height
    }

    @objc private func hideKeyboard() {
        countKeyboardTap = 0
        chekButton.frame.origin.y -= chekButtonLineY
        chekButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func tappedButton() {
        view.endEditing(true)
        autorizationPresenter?.chekPassword(password: passwordTextField.text, login: loginTextField.text)
    }
}

// MARK: - AutorizationViewController + Constraints

extension AutorizationViewController {
    private func makeLoginLabelAnchor() {
        loginTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        loginTitleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginTitleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func makePasswordLabelAnchor() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 79).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func makeLoginTexFieldAnchor() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 6).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func makePasswordTexFieldAnchor() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 7).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func makeChekButtonAnchor() {
        chekButton.translatesAutoresizingMaskIntoConstraints = false
        chekButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        chekButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71).isActive = true
        chekButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        chekButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makeErrorLabelAnchor() {
        errorLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLoginLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        errorLoginLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor).isActive = true
        errorLoginLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        errorLoginLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }

    private func makeErrorLabelPasswordAnchor() {
        errorPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        errorPasswordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        errorPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        errorPasswordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        errorPasswordLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }

    private func makeSplashAnchor() {
        splashView.translatesAutoresizingMaskIntoConstraints = false
        splashView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        splashView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        splashView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        splashView.heightAnchor.constraint(equalToConstant: 87).isActive = true
    }

    private func makeSplashTitleAnchor() {
        splashTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        splashTitleLabel.centerXAnchor.constraint(equalTo: splashView.centerXAnchor).isActive = true
        splashTitleLabel.centerYAnchor.constraint(equalTo: splashView.centerYAnchor).isActive = true
        splashTitleLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        splashTitleLabel.leadingAnchor.constraint(equalTo: splashView.leadingAnchor, constant: 15).isActive = true
        splashTitleLabel.trailingAnchor.constraint(equalTo: splashView.trailingAnchor, constant: -34).isActive = true
    }
}

// MARK: - UITextFieldDelegate

extension AutorizationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        autorizationPresenter?.chekUser(login: loginTextField.text)
    }
}

// MARK: - AutorizationViewControllerProtocol

extension AutorizationViewController: AutorizationViewControllerProtocol {
    func saveUser(email: String, password: String) {
        autorizationPresenter?.saveUser(email: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    func showSpashScreenOn() {
        UIView.animate(withDuration: 0.4) {
            self.splashView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -200)
        }
    }

    func showSpashScreenOff() {
        UIView.animate(withDuration: 0.4) {
            self.splashView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
        }
    }

    func chekValidateUser(imageButton: String?, titleButton: String?) {
        chekButton.setTitle(titleButton, for: .normal)
        chekButton.setImage(UIImage(named: imageButton ?? ""), for: .normal)
        chekButton.imageView?.rotate()
    }

    func setTitleColorPassword(color: String, isValidatePassword: Bool) {
        passwordLabel.textColor = UIColor(named: color)
        passwordTextField.layer.borderColor = UIColor(named: color)?.withAlphaComponent(0.14).cgColor
        errorPasswordLabel.isHidden = isValidatePassword
    }

    func setTitleColorLogin(color: String, isValidateLogin: Bool) {
        loginTitleLabel.textColor = UIColor(named: color)
        loginTextField.layer.borderColor = UIColor(named: color)?.withAlphaComponent(0.14).cgColor
        errorLoginLabel.isHidden = isValidateLogin
    }
}
