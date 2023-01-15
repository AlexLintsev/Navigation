import UIKit

class LogInViewController: UIViewController {

    private var constraintsArray: [NSLayoutConstraint] = []

    private lazy var logoImageView: UIView = {
        let view = UIImageView(image: UIImage(named: "VkLogo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView  = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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

    private enum CellReuseID: String {
        case email = "EmailTableViewCell_ReuseID"
        case password = "PasswordTableViewCell_ReuseID"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubViews()
        setupConstraintsKeyboardHide()
        tuneTableView()
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
        view.addSubview(tableView)
        view.addSubview(loginButton)
    }

    private func tuneTableView() {
        tableView.backgroundColor = .systemGray6
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 10
        tableView.rowHeight = 50
        tableView.alwaysBounceVertical = false

        tableView.register(
            EmailTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.email.rawValue
        )
        tableView.register(
            PasswordTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.password.rawValue
        )

        tableView.dataSource = self
        tableView.delegate = self
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
            tableView.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 120
            )
        ]

        NSLayoutConstraint.activate(constraintsArray)
    }

    private func setupConstraintsKeyboardShow(keyboardHeight: CGFloat) {
        NSLayoutConstraint.deactivate(constraintsArray)

        constraintsArray = getBaseConstraints() + [
            tableView.bottomAnchor.constraint(
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

            tableView.heightAnchor.constraint(equalToConstant: 100),
            tableView.leftAnchor.constraint(
                equalTo: safeAreaGuide.leftAnchor,
                constant: 16
            ),
            tableView.rightAnchor.constraint(
                equalTo: safeAreaGuide.rightAnchor,
                constant: -16
            ),

            loginButton.topAnchor.constraint(
                equalTo: tableView.bottomAnchor,
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

        let tableViewMaxY = view.superview!.convert(tableView.frame, to: nil).maxY

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

        let profileNavigationController = UINavigationController(rootViewController: viewController)

        profileNavigationController.modalTransitionStyle = .coverVertical
        profileNavigationController.modalPresentationStyle = .fullScreen

        present(profileNavigationController, animated: true)
    }
}

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}

extension LogInViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        2
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell: UITableViewCell = {
            if indexPath.row == 0 {
                return tableView.dequeueReusableCell(
                    withIdentifier: CellReuseID.email.rawValue,
                    for: indexPath
                ) as? EmailTableViewCell
            } else {
                return tableView.dequeueReusableCell(
                    withIdentifier: CellReuseID.password.rawValue,
                    for: indexPath
                ) as? PasswordTableViewCell
            }
        }() else {
            fatalError("Could not dequeueReusableCell")
        }
        return cell
    }
}

extension LogInViewController: UITableViewDelegate {

}
