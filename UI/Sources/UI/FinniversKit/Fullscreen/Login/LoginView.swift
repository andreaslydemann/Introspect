//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - LoginViewDelegatew

public protocol LoginViewDelegate: AnyObject {
    func loginView(_ loginView: LoginView, didSelectForgetPasswordButton button: Button)
    func loginView(_ loginView: LoginView, didSelectLoginButton button: Button, with email: String, and password: String)
    func loginView(_ loginView: LoginView, didSelectNewUserButton button: Button, with email: String)
    func loginView(_ loginView: LoginView, didSelectCustomerServiceButton button: Button)
    func loginView(_ loginView: LoginView, didSelectPrivacyPolicyButton button: Button)

    func loginView(_ loginView: LoginView, didOccurIncompleteCredentials incompleteCredentials: Bool)
}

public class LoginView: UIView {
    // MARK: - Internal properties

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var infoLabel: Label = {
        let label = Label(style: .body)
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    fileprivate lazy var emailTextField: TextField = {
        let textField = TextField(inputType: .email)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    fileprivate lazy var passwordTextField: TextField = {
        let textField = TextField(inputType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    private lazy var forgotPasswordButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPasswordButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var loginButton: Button = {
        let button = Button(style: .callToAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var inputsContainer: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var newUserStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spidLogoImageView, newUserButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 11
        return stackView
    }()

    private lazy var spidLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: .spidLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var newUserButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newUserButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var customerServiceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [customerServiceIntroLabel, customerServiceButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var customerServiceIntroLabel: Label = {
        let label = Label(style: .detail)
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var customerServiceButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(customerServiceButtonSelected), for: .touchUpInside)
        return button
    }()

    private lazy var privacyPolicyButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(privacyPolicyButtonSelected), for: .touchUpInside)
        return button
    }()

    fileprivate let buttonHeight: CGFloat = 44

    private var email: String {
        guard let email = emailTextField.text else {
            return ""
        }
        return email
    }

    private var password: String {
        guard let password = passwordTextField.text else {
            return ""
        }
        return password
    }

    // MARK: - Dependency injection

    public var model: LoginViewModel? {
        didSet {
            guard let model = model else {
                return
            }

            infoLabel.text = model.headerText
            emailTextField.placeholderText = model.emailPlaceholder
            passwordTextField.placeholderText = model.passwordPlaceholder
            forgotPasswordButton.setTitle(model.forgotPasswordButtonTitle, for: .normal)
            loginButton.setTitle(model.loginButtonTitle, for: .normal)
            newUserButton.setTitle(model.newUserButtonTitle, for: .normal)
            customerServiceButton.setTitle(model.customerServiceTitle, for: .normal)
            customerServiceIntroLabel.text = model.customerServiceIntro
            privacyPolicyButton.setTitle(model.privacyPolicyTitle, for: .normal)
        }
    }

    // MARK: - External properties

    public weak var delegate: LoginViewDelegate?

    // MARK: - External methods

    public func update(email: String) {
        emailTextField.textField.text = email
    }

    // MARK: - Setup

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override func didMoveToSuperview() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc private func adjustKeyboard(notification: Notification) {
        guard let keyboardEndFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        if notification.name == UIResponder.keyboardWillShowNotification {
            if keyboardEndFrame.intersects(inputsContainer.frame) {
                let intersectionFrame = keyboardEndFrame.intersection(inputsContainer.frame)
                let keyboardOverlap = intersectionFrame.height
                let bottomInset = keyboardOverlap + .spacingM
                let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)

                let animationDuration = ((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? TimeInterval) ?? 0.25
                UIView.animate(withDuration: animationDuration) { [weak self] in
                    self?.adjustKeyboardUp(contentInset: contentInset)
                }
            }
        } else {
            let animationDuration = ((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? TimeInterval) ?? 0.25
            UIView.animate(withDuration: animationDuration) { [weak self] in
                self?.adjustKeyboardDown()
            }
        }
    }

    fileprivate func adjustKeyboardUp(contentInset: UIEdgeInsets) {
        scrollView.contentInset = contentInset
        scrollView.contentOffset = CGPoint(x: 0, y: contentInset.bottom)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    fileprivate func adjustKeyboardDown() {
        scrollView.contentInset = .zero
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    private func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)

        loginButton.isEnabled = false

        scrollView.addSubview(contentView)

        addSubview(scrollView)
        addSubview(customerServiceStackView)

        contentView.addSubview(infoLabel)
        contentView.addSubview(inputsContainer)

        inputsContainer.addSubview(emailTextField)
        inputsContainer.addSubview(passwordTextField)
        inputsContainer.addSubview(loginButton)

        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(newUserStackView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacingXL),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacingXL),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacingXL),

            inputsContainer.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: .spacingM),
            inputsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacingXL),
            inputsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacingXL),

            emailTextField.topAnchor.constraint(equalTo: inputsContainer.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: inputsContainer.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: inputsContainer.trailingAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: .spacingXL),
            passwordTextField.leadingAnchor.constraint(equalTo: inputsContainer.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: inputsContainer.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: .spacingXL),
            loginButton.leadingAnchor.constraint(equalTo: inputsContainer.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: inputsContainer.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            loginButton.bottomAnchor.constraint(equalTo: inputsContainer.bottomAnchor),

            newUserStackView.topAnchor.constraint(equalTo: inputsContainer.bottomAnchor, constant: .spacingM),
            newUserStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacingXL),
            newUserStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            spidLogoImageView.heightAnchor.constraint(equalToConstant: 17),

            forgotPasswordButton.bottomAnchor.constraint(equalTo: newUserStackView.lastBaselineAnchor, constant: .spacingS),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacingXL),

            customerServiceStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -.spacingXXL),
            customerServiceStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingXL)
        ])
    }

    // MARK: - Actions

    @objc func loginButtonSelected() {
        handleTap()
        if emailTextField.isValid && passwordTextField.isValid {
            delegate?.loginView(self, didSelectLoginButton: loginButton, with: email, and: password)
        } else {
            delegate?.loginView(self, didOccurIncompleteCredentials: true)
        }
    }

    @objc func forgotPasswordButtonSelected() {
        handleTap()
        delegate?.loginView(self, didSelectForgetPasswordButton: forgotPasswordButton)
    }

    @objc func newUserButtonSelected() {
        handleTap()
        delegate?.loginView(self, didSelectNewUserButton: newUserButton, with: email)
    }

    @objc func customerServiceButtonSelected() {
        handleTap()
        delegate?.loginView(self, didSelectCustomerServiceButton: customerServiceButton)
    }

    @objc func privacyPolicyButtonSelected() {
        handleTap()
        delegate?.loginView(self, didSelectPrivacyPolicyButton: privacyPolicyButton)
    }

    @objc func handleTap() {
        endEditing(true)
    }
}

// MARK: - TextFieldDelegate

extension LoginView: TextFieldDelegate {
    public func textFieldShouldReturn(_ textField: TextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.textField.becomeFirstResponder()
        } else {
            if loginButton.isEnabled {
                loginButtonSelected()
                textField.textField.resignFirstResponder()
            } else {
                delegate?.loginView(self, didOccurIncompleteCredentials: true)
            }
        }
        return true
    }

    public func textFieldDidChange(_ textField: TextField) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return
        }

        if emailText.isEmpty || passwordText.isEmpty {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
}
