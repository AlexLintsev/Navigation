import UIKit

class ProfileCoordinator: Coordinatable {
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
        (module.viewModel as? ProfileViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
}
