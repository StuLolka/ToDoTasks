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
    
    func getTasks() {
        isLaunchedBefore ? setTasks() : getTasksFromService()
    }
    
    func setTasks() {
        presenter?.setTasks(entity.getTasks())
        presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
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
        case .newTask:
            presenter?.presentCreateTaskView()
        }
    }

    func filterTask(_ type: TaskFilterType) {
        entity.changeSelectedFilter(to: type)
        presenter?.setTasks(entity.getTasks())
        presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
    }

    func toggleIsDone(_ id: UUID) {
        entity.toggleIsDone(id)
        presenter?.setTasks(entity.getTasks())
        presenter?.setFilterButtons(entity.getButtonsData().0, entity.getButtonsData().1, entity.getButtonsData().2)
    }

    func removeTask(_ id: UUID) {
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
            self.entity.setTasksFromService(model)
            DispatchQueue.main.async {
                self.setTasks()
            }
        }
    }

    enum UserDefaultsKey: String {
        case launchedBefore
    }

}

//MARK: - TasksEvent
enum TasksEvent {
    case done(UUID)
    case filter(TaskFilterType)
    case remove(UUID)
    case newTask
}
