import UIKit

class TasksInteractor {

    weak var presenter: TasksPresenterInteractorProtocol?

    private let entity: TasksEntityProtocol = TasksEntity()
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
        isLaunchedBefore ? getTasksFromCoreData() : getTasksFromService()
    }

    func setTasks() {
        DispatchQueue.main.async {
            self.presenter?.setTasks(self.entity.getTasks())
            self.presenter?.setFilterButtons(self.entity.getButtonsData().0, self.entity.getButtonsData().1, self.entity.getButtonsData().2)
        }
    }

    func getTaskViewData() {
        DispatchQueue.main.async {
            self.presenter?.setTaskViewData(self.entity.getTaskViewData())
        }
    }

    func handleEvent(_ event: TasksEvent) {
        switch event {
        case .done(let id):
            toggleIsComplited(id)
        case .filter(let type):
            filterTask(type)
        case .remove(let id):
            removeTask(id)
        case .newTask:
            presenter?.presentCreateTaskView()
        case .taskSelected(let id):
            presenter?.presentEditTaskView(taskModel: entity.getTask(id: id))
        }
    }

    func toggleIsComplited(_ id: UUID) {
        DispatchQueue.global(qos: .utility).async {
            self.entity.toggleIsComplited(id, completion: self.setTasks)
        }
    }

    func filterTask(_ type: TasksFilterType) {
        DispatchQueue.global(qos: .utility).async {
            self.entity.changeSelectedFilter(to: type, completion: self.setTasks)
        }
    }

    func removeTask(_ id: UUID) {
        DispatchQueue.global(qos: .utility).async {
            self.entity.removeTask(id, completion: self.setTasks)
        }
    }

}

//MARK: - private
private extension TasksInteractor {

    func getTasksFromService() {
        service.fetchTasks { model in
            DispatchQueue.global(qos: .utility).async {
                self.entity.setTasksFromService(model, completion: self.setTasks)
            }
        }
    }

    func getTasksFromCoreData() {
        DispatchQueue.global(qos: .utility).async {
            self.entity.setTasksFromCoreDara(completion: self.setTasks)
        }
    }

    enum UserDefaultsKey: String {
        case launchedBefore
    }

}

//MARK: - TasksEvent
enum TasksEvent {
    case done(UUID)
    case filter(TasksFilterType)
    case remove(UUID)
    case newTask
    case taskSelected(UUID)
}

//MARK: - TasksCollectionViewCellData
struct TasksCollectionViewCellData {
    let id: UUID
    let title: String
    let attributeString: NSAttributedString
    let subtitle: String
    let date: String
    let doneButtonImage: UIImage
    let tintColorButton: UIColor
}
