import Foundation

class Logger {
    static let shared = Logger()
    private init() {}

    func printLog(_ event: LoggerEvent) {
        switch event {
        case .foundNil(let place): print("❗️ found nil in \(place)")
        case .contextError(let error): print("❗️ found nil in \(error)")
            
        }
    }

}

enum LoggerEvent {
    case foundNil(String)
    case contextError(String)
}
