import UIKit
import CoreData

class TaskEntity {

    private let title = "Today's Task"
    private let buttonTitle = "New Task"
    private var selectedFilter = TaskFilterType.all

    private var tasks: [TaskModel] {
        CoreManager.shared.getTasks()
    }

    private var openTasks: [TaskModel] {
        tasks.filter { !$0.isComplited }
    }

    private var closedTasks: [TaskModel] {
        tasks.filter { $0.isComplited }
    }
}

//MARK: - TaskEntityProtocol
extension TaskEntity: TaskEntityProtocol {

    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData) {
        let allButton = FilterButtonData(title: "All", number: String(tasks.count), isSelected: selectedFilter == .all)
        let openButton = FilterButtonData(title: "Open", number: String(openTasks.count), isSelected: selectedFilter == .open)
        let closedButton = FilterButtonData(title: "Closed", number: String(closedTasks.count), isSelected: selectedFilter == .closed)
        return (allButton, openButton, closedButton)
    }

    func getTaskViewData() -> TaskViewData {
        return TaskViewData(title: title, date: String.currentDate, buttonTitle: buttonTitle)
    }

    func getTasks() -> [TaskModel] {
        switch selectedFilter {
        case .all: return tasks
        case .open: return openTasks
        case .closed: return closedTasks
        }
    }

    func changeSelectedFilter(to filter: TaskFilterType) {
        selectedFilter = filter
    }

    func toggleIsDone(_ id: UUID) {
        guard let index = (tasks.firstIndex { $0.id == id }) else { return }
        tasks[index].updateIsComplited()
    }

    func setTasksFromService(_ tasks: TaskServerModel) {
        tasks.todos.forEach {
            CoreManager.shared.saveTaskFromServer($0)
        }
    }

    func removeTask(_ id: UUID) {
        guard let index = (tasks.firstIndex { $0.id == id }) else { return }
        tasks[index].remove()
    }

}

//MARK: - TaskViewData
struct TaskViewData {
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
enum TaskFilterType {
    case all
    case open
    case closed
}
