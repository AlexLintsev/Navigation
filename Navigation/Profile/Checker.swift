class Checker {
    static let share = Checker()

    private let login = "Alex123"
    private let password = "qwerty"

    private init() {}

    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }

}
