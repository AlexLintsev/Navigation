import UIKit

class CurrentUserService: UserService {

    private var user = User(
        name: "Alexander",
        login: "Alex123",
        status: "Сплю",
        avatar: UIImage(named: "cat")!
    )

    func checkLogin(_ login: String) -> User? {
        return login == user.login ? user : nil
    }
}
