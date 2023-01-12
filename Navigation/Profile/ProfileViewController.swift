import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = { [unowned self] in
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var someButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.setTitle("Нерабочая кнопка", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        view.backgroundColor = .lightGray

        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "profile")

        self.tabBarItem = tabBarItem

        view.addSubview(profileHeaderView)
        view.addSubview(someButton)

        setupConstaints()
    }

    private func setupConstaints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),

            someButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            someButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            someButton.heightAnchor.constraint(equalToConstant: 50),
            someButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}
