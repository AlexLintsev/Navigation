import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let urlReq: URL
        switch configuration {
        case .config1 (let urlStr):
            print("*****")
            print("Выбрана конфигурация 1. URL = \(urlStr)")
            print("*****")
            guard let url = URL(string: urlStr) else { return }
            urlReq = url
        case .config2(let urlStr):
            print("*****")
            print("Выбрана конфигурация 2. URL = \(urlStr)")
            print("*****")
            guard let url = URL(string: urlStr) else { return }
            urlReq = url
        case .config3(let urlStr):
            print("*****")
            print("Выбрана конфигурация 3. URL = \(urlStr)")
            print("*****")
            guard let url = URL(string: urlStr) else { return }
            urlReq = url
        }

        let request = URLRequest(url: urlReq)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Error occured: \(error.localizedDescription)")
                // Код ошибки при выключенном интернете =-1009
                // Error Domain=kCFErrorDomainCFNetwork Code=-1009
                return
            }

            do {
                guard let data else { return }
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                print("Data request = \(jsonDictionary)")

            } catch {
                print("Что-то пошло не так")
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code = \(httpResponse.statusCode)")
                print("Response headers = \(httpResponse.allHeaderFields)")
            }
        }

        dataTask.resume()
    }
}
