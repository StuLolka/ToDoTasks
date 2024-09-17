import Foundation

class TasksInteractor {
    weak var presenter: TasksPresenterProtocol?
    private let entity: TaskEntityProtocol = TaskEntity()
    private let service: ServiceProtocol = Service()

    private var isLaunchedBefore: Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKey.launchedBefore.rawValue)
        if !launchedBefore  {
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.launchedBefore.rawValue)
        }
        return launchedBefore
    }
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
        if !isLaunchedBefore {
            getTasksFromService()
        } else {
            presenter?.setTasks(entity.getTasks())
            presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
        }
    }

    func getTaskViewData() -> TaskViewData {
        entity.getTaskViewData()
    }

    func handleEvent(_ event: TasksEvent) {
        switch event {
        case .done(let id):
            toggleIsDone(id)
        case .filter(let type):
            filterTask(type)
        case .remove(let id):
            removeTask(id)
        }
    }

    func filterTask(_ type: TaskFilterType) {
        entity.changeSelectedFilter(to: type)
        presenter?.setTasks(entity.getTasks())
    }

    func toggleIsDone(_ id: Int) {
        entity.toggleIsDone(id)
        presenter?.setTasks(entity.getTasks())
        presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
    }

    func removeTask(_ id: Int) {
        entity.removeTask(id)
        presenter?.setTasks(entity.getTasks())
        presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
    }

    func updateTask(_ id: Int) {}

    func saveTasks() {}

}

//MARK: - private
private extension TasksInteractor {

    func getTasksFromService() {
        service.fetchTasks { model in
            let tasks = model.todos.map { TasksCollectionViewCellData(id: $0.id, title: $0.todo, subtitle: $0.todo, date: self.getCurrentDate(), isDone: $0.completed) }
            self.entity.setTasksFromService(tasks)
            self.presenter?.setTasks(self.entity.getTasks())
            self.presenter?.setFilterButtons(self.entity.getButtonsData().0, self.entity.getButtonsData().1, self.entity.getButtonsData().2)
        }
    }

    enum UserDefaultsKey: String {
        case launchedBefore
    }

}

//MARK: - TasksEvent
enum TasksEvent {
    case done(Int)
    case filter(TaskFilterType)
    case remove(Int)
}
