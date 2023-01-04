import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        view.backgroundColor = .systemGreen

        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: "profile")

        self.tabBarItem = tabBarItem
    }
}
