import Foundation

class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
    private let entity: TaskEntityProtocol = TaskEntity()
}

//MARK: - TasksInteractorProtocol
extension TasksInteractor: TasksInteractorProtocol {

    func getTasks() -> [TasksCollectionViewCellData] {
        entity.getTasks()
    }

    func getTaskViewData() -> TaskViewData {
        entity.getTaskViewData()
    }

    func toggleIsDone(_ id: Int) {
        entity.toggleIsDone(id)
        presenter?.reloadTasks()
    }

    func updateTask(_ id: Int) {}

    func saveTasks() {}

}
