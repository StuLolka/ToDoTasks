import Foundation

class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
    private let entity: TaskEntityProtocol = TaskEntity()
    private let service: ServiceProtocol = Service()
}

//MARK: - TasksInteractorProtocol
extension TasksInteractor: TasksInteractorProtocol {

    func getCurrentDate() -> String {
        entity.currentDate
    }

    func getTitle() -> String {
        entity.title
    }

    func getButtonTitle() -> String {
        entity.buttonTitle
    }

    func getTasks() {
        isLaunchedBefore() ? presenter?.reloadTasks(entity.getTasks()) : getTasksFromService()
    }

    func getTaskViewData() -> TaskViewData {
        entity.getTaskViewData()
    }

    func filterTask(type: TaskFilterType) {
        entity.changeSelectedFilter(to: type)
        presenter?.reloadTasks(entity.getTasks())
    }

    func toggleIsDone(_ id: Int) {
        entity.toggleIsDone(id)
        presenter?.reloadTasks(entity.getTasks())
    }

    func getFilterButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData) {
        entity.getButtonsData()
    }

    func updateTask(_ id: Int) {}

    func saveTasks() {}

}

//MARK: - private
private extension TasksInteractor {

    func isLaunchedBefore() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKey.launchedBefore.rawValue)
        if !launchedBefore  {
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.launchedBefore.rawValue)
        }
        return launchedBefore
    }

    func getTasksFromService() {
        service.fetchTasks { model in
            let tasks = model.todos.map { TasksCollectionViewCellData(id: $0.id, title: $0.todo, subtitle: $0.todo, date: self.getCurrentDate(), isDone: $0.completed) }
            self.entity.setTasksFromService(tasks)
            self.presenter?.reloadTasks(self.entity.getTasks())
        }
    }

    enum UserDefaultsKey: String {
        case launchedBefore
    }
}
