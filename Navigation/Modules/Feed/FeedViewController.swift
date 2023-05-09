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
            guard textField.text != nil && textField.text != "" else {
                let alert = UIAlertController(
                    title: "Поле с паролем не заполнено",
                    message: "Введите пароль в текстовое поле",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default
                ))
                present(alert, animated: true, completion: nil)
                label.isHidden = true
                return
            }
            let isWordCorrect = feedModel.check(word: textField.text!)
            label.backgroundColor = isWordCorrect ? .green : .red
            label.isHidden = false
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
