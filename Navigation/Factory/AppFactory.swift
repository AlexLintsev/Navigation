import UIKit

final class AppFactory {

    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .login:
            let viewModel = LoginViewModel()
            let loginViewController = LogInViewController(viewModel: viewModel)
            let logInFactory = MyLogInFactory()
            loginViewController.loginDelegate = logInFactory.makeLogInInspector()
            let view = UINavigationController(rootViewController: loginViewController)
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .profile:
            let viewModel = ProfileViewModel()
            let userService: UserService
            #if DEBUG
            userService = TestUserService()
            #else
            userService = CurrentUserService()
            #endif
            let view = UINavigationController(rootViewController: ProfileViewController(user: userService.getUser()))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .feed:
            let viewModel = FeedViewModel()
            let view = UINavigationController(rootViewController: FeedViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }
}

