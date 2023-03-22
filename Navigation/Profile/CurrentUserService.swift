import UIKit

class CurrentUserService: UserService {

    private var user = User(
        name: "Alexander",
        status: "Сплю",
        avatar: UIImage(named: "cat")!
    )

    func getUser() -> User {
        user
    }
}
