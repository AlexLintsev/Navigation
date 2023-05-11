import UIKit

protocol ViewModelProtocol: AnyObject {

}

struct Module {
    enum ModuleType {
        case feed
        case login
        case profile
    }

    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .profile, .login:
            let tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)
            tabBarItem.imageInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
            return tabBarItem
        case .feed:
            let tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 1)
            tabBarItem.imageInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
            return tabBarItem
        }
    }
}
