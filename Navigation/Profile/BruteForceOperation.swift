import UIKit

class BruteForceOperation: Operation {

    private let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
    private let loginViewController: LogInViewController

    init(loginViewController: LogInViewController) {
        self.loginViewController = loginViewController
    }

    func bruteForce(passwordToUnlock: String) {
        var password: String = ""

        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
    }

    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        return str
    }

    func generateRandomPassword(length: Int) -> String {
        var randomPassword = ""
        var iteration = 1
        guard length > 0 else {
            print("Length of generating passwword must be > 0")
            return randomPassword
        }
        while iteration <= length {
            randomPassword += ALLOWED_CHARACTERS[Int.random(in: 0...ALLOWED_CHARACTERS.count - 1)]
            iteration += 1
        }
        return randomPassword
    }

    override func main() {
        if self.isCancelled {
            return
        }
        DispatchQueue.main.async {
            self.loginViewController.showIndicator()
        }
        let generatedPassword = generateRandomPassword(length: 4)
        bruteForce(passwordToUnlock: generatedPassword)
        DispatchQueue.main.async {
            self.loginViewController.hideIndicator()
            self.loginViewController.changeTextFieldValue(password: generatedPassword)
        }
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
