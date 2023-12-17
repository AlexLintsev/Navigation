import UIKit

class FeedViewController: UIViewController {

    private let post = "Title from feedController"

    private let feedModel = FeedModel()

    private lazy var button1 = CustomButton(
        isUserInteractionEnabled: true,
        titleLabel: "First",
        backgroundColor: .systemGreen,
        imageName: nil
    )

    private lazy var button2 = CustomButton(
        isUserInteractionEnabled: true,
        titleLabel: "Second",
        backgroundColor: .systemGreen,
        imageName: nil
    )

    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(self.button1)
        stackView.addArrangedSubview(self.button2)
        return stackView
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите секретное слово"
        return textField
    }()

    private lazy var checkGuessButton = CustomButton(
        isUserInteractionEnabled: true,
        titleLabel: "Проверить пароль",
        backgroundColor: .systemGreen,
        imageName: nil
    )

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        view.backgroundColor = .systemGreen
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "feed")
        tabBarItem.imageInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        tabBarItem.title = "Feed"
        self.tabBarItem = tabBarItem
        view.addSubview(stackView)
        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(label)
        setupProperties(for: button1)
        setupProperties(for: button2)
        setupProperties(for: checkGuessButton)
        setupConstraints()
        setupActions()
    }

    private func setupActions() {
        button1.tapAction = {
            let viewController = PostViewController()
            viewController.postTitle = self.post

            let postNavigationController = UINavigationController(rootViewController: viewController)

            postNavigationController.modalTransitionStyle = .crossDissolve
            postNavigationController.modalPresentationStyle = .fullScreen

            self.present(postNavigationController, animated: true)
        }

        button2.tapAction = button1.tapAction

        checkGuessButton.tapAction = { [self] in
            checkPassword { [self] result in
                switch result {
                case .success(let alert):
                    label.backgroundColor = .green
                    label.isHidden = false
                    present(alert, animated: true, completion: nil)
                case .failure(let error):
                    handle(error: error)
                }
            }
        }
    }

    private func checkPassword(completition: @escaping ((Result<UIAlertController, PasswordError>)) -> Void) {
        guard textField.text != nil && textField.text != "" else {
            completition(.failure(.emptyPassword))
            return
        }
        let isWordCorrect = feedModel.check(word: textField.text!)
        if !isWordCorrect {
            completition(.failure(.wrongPassword))
        } else {
            completition(.success(getAlertController(error: nil)))
        }
    }

    private func getAlertController(error: PasswordError?) -> UIAlertController {
        var alert = UIAlertController()
        switch error {
        case .emptyPassword:
            alert = UIAlertController(
                title: "Пароль не введен",
                message: "Введите пароль",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default
            ))
        case .wrongPassword:
            alert = UIAlertController(
                title: "Пароль введен неверно",
                message: "Повторите попытку",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default
            ))
        default:
            alert = UIAlertController(
                title: "Пароль введен успешно",
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default
            ))
        }
        return alert
    }

    private func handle(error: PasswordError) {
        print(error.localizedDescription)
        switch error {
        case .emptyPassword:
            label.isHidden = true
            present(getAlertController(error: .emptyPassword), animated: true, completion: nil)
        case .wrongPassword:
            label.backgroundColor = .red
            label.isHidden = false
            present(getAlertController(error: .wrongPassword), animated: true, completion: nil)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 16
            ),
            stackView.rightAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -16
            ),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),

            textField.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            textField.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            textField.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: 16
            ),
            checkGuessButton.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            checkGuessButton.rightAnchor.constraint(
                equalTo: stackView.rightAnchor,
                constant: -56
            ),
            checkGuessButton.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: 16
            ),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),

            label.leftAnchor.constraint(
                equalTo: checkGuessButton.rightAnchor,
                constant: 16
            ),
            label.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            label.centerYAnchor.constraint(equalTo: checkGuessButton.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupProperties(for button: UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }
}

enum PasswordError: Error {
    case wrongPassword
    case emptyPassword
}

extension PasswordError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wrongPassword:
            return NSLocalizedString("Пароль введен неверно", comment: "My error1")
        case .emptyPassword:
            return NSLocalizedString("Пароль не введен", comment: "My error2")
        }
    }
}
