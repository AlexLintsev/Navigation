struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.share.check(login: login, password: password)
    }
}
