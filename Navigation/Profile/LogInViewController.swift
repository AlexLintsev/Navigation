import UIKit

class LogInViewController: UIViewController {

    private var constraintsArray: [NSLayoutConstraint] = []

    private lazy var logoImageView: UIView = {
        let view = UIImageView(image: UIImage(named: "VkLogo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }()

    private lazy var emailTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "systemFont", size: 16)
        textField.textColor = .black
        textField.placeholder = "Email or phone"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocapitalizationType = .none
        return textField
    }()

    private lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "systemFont", size: 16)
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.setTitle("Log In", for: .normal)
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(image!.withAlpha(0.8), for: .selected)
        button.setBackgroundImage(image!.withAlpha(0.8), for: .disabled)
        button.setBackgroundImage(image!.withAlpha(0.8), for: .highlighted)
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubViews()
        setupConstraintsKeyboardHide()
        setupActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupKeyboardObservers()
    }

    private func setupView() {
        view.backgroundColor = .white
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "profile")
        tabBarItem.imageInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        tabBarItem.title = "Profile"
        self.tabBarItem = tabBarItem
    }

    private func addSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(loginView)
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(separatorView)
        view.addSubview(loginButton)
    }

    private func setupActions() {
        loginButton.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )
    }

    private func setupConstraintsKeyboardHide() {
        NSLayoutConstraint.deactivate(constraintsArray)

        constraintsArray = getBaseConstraints() + [
            loginView.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 120
            )
        ]

        NSLayoutConstraint.activate(constraintsArray)
    }

    private func setupConstraintsKeyboardShow(keyboardHeight: CGFloat) {
        NSLayoutConstraint.deactivate(constraintsArray)

        constraintsArray = getBaseConstraints() + [
            loginView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -keyboardHeight
            )
        ]

        NSLayoutConstraint.activate(constraintsArray)
    }

    private func getBaseConstraints() -> [NSLayoutConstraint] {
        let safeAreaGuide = view.safeAreaLayoutGuide

        return [
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            logoImageView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 120
            ),

            loginView.heightAnchor.constraint(equalToConstant: 100),
            loginView.leftAnchor.constraint(
                equalTo: safeAreaGuide.leftAnchor,
                constant: 16
            ),
            loginView.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),

            emailTextField.topAnchor.constraint(equalTo: loginView.topAnchor),
            emailTextField.leftAnchor.constraint(equalTo: loginView.leftAnchor),
            emailTextField.rightAnchor.constraint(equalTo: loginView.rightAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: loginView.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: loginView.rightAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            separatorView.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            separatorView.leftAnchor.constraint(equalTo: loginView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: loginView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),

            loginButton.topAnchor.constraint(
                equalTo: loginView.bottomAnchor,
                constant: 16
            ),
            loginButton.leftAnchor.constraint(
                equalTo: safeAreaGuide.leftAnchor,
                constant: 16
            ),
            loginButton.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ]
    }


    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }

    @objc private func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0.0

        let tableViewMaxY = view.superview!.convert(loginView.frame, to: nil).maxY

        if view.bounds.maxY - keyboardHeight < tableViewMaxY {
            setupConstraintsKeyboardShow(keyboardHeight: keyboardHeight)

            view.layoutIfNeeded()
        }
    }

    @objc private func willHideKeyboard(_ notification: NSNotification) {

        setupConstraintsKeyboardHide()

        view.layoutIfNeeded()
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        let viewController = ProfileViewController()

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
