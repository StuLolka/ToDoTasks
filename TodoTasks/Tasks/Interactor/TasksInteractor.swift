import Foundation

class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
    private let entity: TaskEntityProtocol = TaskEntity()
}

extension TasksInteractor: TasksInteractorProtocol {

    func getTaskViewDataSource() -> TaskViewDataSource {
        entity.getTaskViewDataSource()
    }

    func downloadTasks() {}

    func saveTasks() {}
}
