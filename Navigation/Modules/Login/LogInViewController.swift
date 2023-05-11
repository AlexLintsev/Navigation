import UIKit

class LogInViewController: UIViewController {
    var loginDelegate: LoginViewControllerDelegate?

    private let viewModel: LoginViewModelProtocol

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

    private lazy var errorLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Неверное имя пользователя или пароль"
        label.textColor = .red
        label.font = UIFont(name: "systemFont", size: 16)
        label.isHidden = true
        return label
    }()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubViews()
        setupConstraintsKeyboardHide()
        setupActions()
        bindViewModel()
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
        view.addSubview(errorLoginLabel)
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
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            errorLoginLabel.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: 16
            ),
            errorLoginLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
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

    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initialLogin:
                return
            case .loginEmpty:
                let alert = UIAlertController(
                    title: "Поле логин/пароль не заполнено",
                    message: "Заполните необходимые поля данными",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default
                ))
                self.present(alert, animated: true, completion: nil)
                return
            case .loginFail:
                let alert = UIAlertController(
                    title: "Введен неверный логин/пароль",
                    message: "Попробуйте еще раз",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default
                ))
                self.present(alert, animated: true, completion: nil)
                return
            case .loginSuccess:
                let userService: UserService
                #if DEBUG
                userService = TestUserService()
                #else
                userService = CurrentUserService()
                #endif
                let viewController = ProfileViewController(user: userService.getUser())
                guard var viewControllers = self.navigationController?.viewControllers else { return }
                _ = viewControllers.popLast()
                viewControllers.append(viewController)
                self.navigationController?.setViewControllers(viewControllers, animated: true)
            }
        }
    }

    private func checkLogin() -> Bool? {
        guard !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty else {
            return nil
        }
        return loginDelegate?.check(
            login: emailTextField.text!,
            password: passwordTextField.text!
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
//        let userService: UserService
//
//        #if DEBUG
//        userService = TestUserService()
//        #else
//        userService = CurrentUserService()
//        #endif
//
//        guard let isLoginCorrect = loginDelegate?.check(
//            login: emailTextField.text ?? "",
//            password: passwordTextField.text ?? ""
//        ) else { return }
//
//        if !isLoginCorrect {
//            let alert = UIAlertController(
//                title: "Введен неверный логин/пароль",
//                message: "Попробуйте еще раз",
//                preferredStyle: .alert
//            )
//            alert.addAction(UIAlertAction(
//                title: NSLocalizedString("OK", comment: "Default action"),
//                style: .default
//            ))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
//
//        let viewController = ProfileViewController(user: userService.getUser())
//
//        guard var viewControllers = navigationController?.viewControllers else { return }
//        _ = viewControllers.popLast()
//        viewControllers.append(viewController)
//        navigationController?.setViewControllers(viewControllers, animated: true)
        self.viewModel.isLoginCorrect = checkLogin()
        self.viewModel.updateState(viewInput: .loginButtonDidTap)
    }
}

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
