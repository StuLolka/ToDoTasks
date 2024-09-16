import Foundation

protocol ServiceProtocol {
    func fetchTasks(completion: @escaping (TodoModel) -> ())
}
