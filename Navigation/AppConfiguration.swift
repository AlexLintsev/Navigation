import UIKit

enum AppConfiguration: CaseIterable {
    static var allCases: [AppConfiguration] {
        return [
            config1("https://swapi.dev/api/people/1"),
            config2("https://swapi.dev/api/planets/1"),
            config3("https://swapi.dev/api/films/1")
        ]
    }

    case config1(String)
    case config2(String)
    case config3(String)
}
