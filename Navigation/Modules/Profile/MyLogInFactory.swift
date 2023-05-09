struct MyLogInFactory: LogInFactory {
    func makeLogInInspector() -> LoginInspector {
        LoginInspector()
    }
}
