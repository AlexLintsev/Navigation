import UIKit

class FeedViewController: UIViewController {

    private let post = Post(title: "Title from feedController")

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть пост", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        view.backgroundColor = .systemGreen

        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "feed")

        self.tabBarItem = tabBarItem

        view.addSubview(actionButton)

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])

        actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let viewController = PostViewController()
        viewController.postTitle = post.title

        let postNavigationController = UINavigationController(rootViewController: viewController)
        postNavigationController.modalTransitionStyle = .crossDissolve
        postNavigationController.modalPresentationStyle = .fullScreen

        present(postNavigationController, animated: true)
    }
}
