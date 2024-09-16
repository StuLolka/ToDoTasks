import Foundation

struct TodoModel: Decodable {
    let todos: [Todos]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Todos: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
