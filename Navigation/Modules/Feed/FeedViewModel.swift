import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((FeedViewModel.State) -> Void)? { get set }
    var isPasswordCorrect: Bool? { get set }
    func updateState(viewInput: FeedViewModel.ViewInput)
}

class FeedViewModel: FeedViewModelProtocol {

    enum State {
        case initialFeed
        case passwordCorrect
        case passwordWrong
        case passwordEmpty
    }

    enum ViewInput {
        case simpleButtonDidTap
        case checkGuessButtonDidTap
    }

    weak var coordinator: FeedCoordinator?

    private static let secretWord = "Пароль"

    var isPasswordCorrect: Bool?

    var onStateDidChange: ((State) -> Void)?

    private(set) var state: State = .initialFeed {
        didSet {
            onStateDidChange?(state)
        }
    }

    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .simpleButtonDidTap:
            coordinator?.pushViewController()
            break
        case .checkGuessButtonDidTap:
            guard let isPasswordCorrect = isPasswordCorrect else {
                state = .passwordEmpty
                return
            }
            state = isPasswordCorrect ? .passwordCorrect : .passwordWrong
        }
    }

    static func check(word: String) -> Bool {
        secretWord == word
    }
}
