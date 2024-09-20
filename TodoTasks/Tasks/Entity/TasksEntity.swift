import UIKit
import CoreData

class TasksEntity {

    private let title = "Today's Task"
    private let buttonTitle = "New Task"
    private var selectedFilter = TasksFilterType.all

    private var tasks = [TaskModel]()

    private var openTasks: [TaskModel] {
        tasks.filter { !$0.isComplited }
    }

    private var closedTasks: [TaskModel] {
        tasks.filter { $0.isComplited }
    }
}

//MARK: - TaskEntityProtocol
extension TasksEntity: TasksEntityProtocol {

    func getTask(id: UUID) -> TaskModel? {
        guard let index = (tasks.firstIndex { $0.id == id }) else { return nil }
        return tasks[index]
    }

    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData) {
        let allButton = FilterButtonData(title: "All", number: String(tasks.count), isSelected: selectedFilter == .all)
        let openButton = FilterButtonData(title: "Open", number: String(openTasks.count), isSelected: selectedFilter == .open)
        let closedButton = FilterButtonData(title: "Closed", number: String(closedTasks.count), isSelected: selectedFilter == .closed)
        return (allButton, openButton, closedButton)
    }

    func getTaskViewData() -> TasksViewData {
        return TasksViewData(title: title, date: String.currentDate, buttonTitle: buttonTitle)
    }

    func getTasks() -> [TaskModel] {
        switch selectedFilter {
        case .all: return tasks
        case .open: return openTasks
        case .closed: return closedTasks
        }
    }

    func changeSelectedFilter(to filter: TasksFilterType, completion: @escaping (() -> ())) {
        selectedFilter = filter
        completion()
    }

    func toggleIsComplited(_ id: UUID, completion: @escaping (() -> ())) {
        guard let index = (tasks.firstIndex { $0.id == id }) else { return }
        tasks[index].updateIsComplited()
        completion()
    }

    func setTasksFromService(_ tasks: TaskServerModel, completion: @escaping (() -> ())) {
        tasks.todos.forEach {
            CoreDataManager.shared.saveTaskFromServer($0)
        }
        setTasksFromCoreDara(completion: completion)
    }

    func setTasksFromCoreDara(completion: @escaping (() -> ())) {
        tasks = CoreDataManager.shared.getTasks().sorted { $0.date > $1.date }
        completion()
    }

    func removeTask(_ id: UUID, completion: @escaping (() -> ())) {
        guard let index = (tasks.firstIndex { $0.id == id }) else { return }
        tasks[index].remove()
        tasks.remove(at: index)
        completion()
    }

}

//MARK: - TasksViewData
struct TasksViewData {
    let title: String
    let date: String
    let buttonTitle: String
}

//MARK: - FilterButtonData
struct FilterButtonData {
    let title: String
    let number: String
    let isSelected: Bool
}

//MARK: - FilterButtonType
enum TasksFilterType {
    case all
    case open
    case closed
}
