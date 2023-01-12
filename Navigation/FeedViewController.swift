import UIKit

class FeedViewController: UIViewController {

    private let post = Post(title: "Title from feedController")

    private lazy var button1: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("First", for: .normal)
        setupProperties(for: button)
        return button
    }()

    private lazy var button2: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("Second", for: .normal)
        setupProperties(for: button)
        return button
    }()

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
        setupConstraints()
        setupActions()
    }

    private func setupActions() {
        button1.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )

        button2.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: .touchUpInside
        )
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        let viewController = PostViewController()
        viewController.postTitle = post.title

        let postNavigationController = UINavigationController(rootViewController: viewController)

        postNavigationController.modalTransitionStyle = .crossDissolve
        postNavigationController.modalPresentationStyle = .fullScreen

        present(postNavigationController, animated: true)
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
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupProperties(for button: UIButton) {
        button.backgroundColor = .systemGreen
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
