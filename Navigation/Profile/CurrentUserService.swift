import UIKit

class CurrentUserService: UserService {

    private var user: User

    init(_ user: User) {
        self.user = user
    }

    func checkLogin(_ login: String) -> User? {
        return login == user.login ? user : nil
    }
}
