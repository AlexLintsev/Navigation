import UIKit

class User {

    let name: String
    let login: String
    var status: String
    var avatar: UIImage

    init(name: String, login: String, status: String, avatar: UIImage) {
        self.name = name
        self.login = login
        self.status = status
        self.avatar = avatar
    }
}
