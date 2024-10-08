import Foundation

//MARK: - TaskServerModel
struct TaskServerModel: Decodable {
    let todos: [Todos]
    let total: Int
    let skip: Int
    let limit: Int
}

//MARK: - Todos
struct Todos: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
