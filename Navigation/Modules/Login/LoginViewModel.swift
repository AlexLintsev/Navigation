import Foundation

protocol LoginViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((LoginViewModel.State) -> Void)? { get set }
    var isLoginCorrect: Bool? { get set }
    func updateState(viewInput: LoginViewModel.ViewInput)
}

class LoginViewModel: LoginViewModelProtocol {

    var isLoginCorrect: Bool?

    enum State {
        case initialLogin
        case loginSuccess
        case loginFail
        case loginEmpty
    }

    enum ViewInput {
        case loginButtonDidTap
    }

    weak var coordinator: LoginCoordinator?

    private(set) var state: State = .initialLogin {
        didSet {
            onStateDidChange?(state)
        }
    }

    var onStateDidChange: ((State) -> Void)?

    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .loginButtonDidTap:
            guard let isLoginCorrect = isLoginCorrect else {
                state = .loginEmpty
                return
            }
            state = isLoginCorrect ? .loginSuccess : .loginFail
        }
    }
}
