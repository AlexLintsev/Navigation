import UIKit

class TestUserService: UserService {

    private var user = User(
        name: "Test",
        status: "Testing",
        avatar: UIImage(named: "cat")!
    )

    func getUser() -> User {
        user
    }
}
