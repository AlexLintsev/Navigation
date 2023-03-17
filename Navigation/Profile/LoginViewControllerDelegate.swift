protocol LoginViewControllerDelegate: Any {
    func check(login: String, password: String) -> Bool
}
