import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        view.backgroundColor = .lightGray

        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "profile")

        self.tabBarItem = tabBarItem
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let profileHeaderView = ProfileHeaderView(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 60),
                size: CGSize(width: view.frame.width, height: view.frame.height - 60)
            )
        )

        view.addSubview(profileHeaderView)
    }
}
