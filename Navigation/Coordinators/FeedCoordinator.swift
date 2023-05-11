import UIKit

class FeedCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType

    private let factory: AppFactory

    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?

    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }

    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? FeedViewModel)?.coordinator = self
        self.module = module
        return viewController
    }

    func pushViewController() {
        let viewControllerToPush = PostViewController()

        let postNavigationController = UINavigationController(rootViewController: viewControllerToPush)

        postNavigationController.modalTransitionStyle = .crossDissolve
        postNavigationController.modalPresentationStyle = .fullScreen
        (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
    }
}
