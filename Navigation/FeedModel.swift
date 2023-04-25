import UIKit

class FeedModel {

    private let secretWord = "Пароль"

    func check(word: String) -> Bool {
        secretWord == word
    }
}
