import UIKit

class TestUserService: UserService {

    private var user = User(
        name: "Test",
        login: "Test123",
        status: "Testing",
        avatar: UIImage(named: "cat")!
    )

    func checkLogin(_ login: String) -> User? {
        return login == user.login ? user : nil
    }
}
