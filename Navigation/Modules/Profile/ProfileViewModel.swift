import Foundation

protocol ProfileViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((ProfileViewModel.State) -> Void)? { get set }
    func updateState(viewInput: ProfileViewModel.ViewInput)
}

final class ProfileViewModel: ProfileViewModelProtocol {

    enum State {
        case initialProfile
        case statusChanged
        case arrowButtonDidTap
    }

    enum ViewInput {
        case setStatusButtonDidTap
        case arrowButtonDidTap
    }

    weak var coordinator: ProfileCoordinator?

    var onStateDidChange: ((State) -> Void)?

    private(set) var state: State = .initialProfile {
        didSet {
            onStateDidChange?(state)
        }
    }

    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .setStatusButtonDidTap:
            
        }
    }
}
