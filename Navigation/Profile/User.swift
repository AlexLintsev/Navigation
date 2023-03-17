import UIKit

class User {

    let name: String
    var status: String
    var avatar: UIImage

    init(name: String, status: String, avatar: UIImage) {
        self.name = name
        self.status = status
        self.avatar = avatar
    }
}
