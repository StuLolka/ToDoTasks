import Foundation

class TaskEntity {

    private var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        return dateFormatter.string(from: date)
    }

    private let title = "Today's Task"
    private let buttonTitle = "New Task"
    private let allButton = FilterButtonData(title: "All", number: "0", isSelected: true)
    private let openButton = FilterButtonData(title: "Open", number: "0", isSelected: false)
    private let closedButton = FilterButtonData(title: "Closed", number: "0", isSelected: false)

    private var testTasks = [TasksCollectionViewCellData(id: 1, title: "Task 1", subtitle: "Subtitle task 1", date: "Some date i dont give a fuck", isDone: false),
                            TasksCollectionViewCellData(id: 2, title: "Task 2", subtitle: "Subtitle task 2", date: "Some date i dont give a fuck", isDone: true),
                            TasksCollectionViewCellData(id: 3, title: "Task 3", subtitle: "Subtitle task 3 tratatatat", date: "Some date i dont give a fuck", isDone: true),
                            TasksCollectionViewCellData(id: 4, title: "Task 4", subtitle: "Subtitle task 4 long long long", date: "Some date i dont give a fuck", isDone: false),
                            TasksCollectionViewCellData(id: 5, title: "Task 5", subtitle: "Subtitle task 5", date: "Some date i dont give a fuck", isDone: false),
                            TasksCollectionViewCellData(id: 6, title: "Task 6", subtitle: "Subtitle task 6", date: "Some date i dont give a fuck", isDone: true),
                            TasksCollectionViewCellData(id: 7, title: "Task 7", subtitle: "Subtitle task 7 tratatatat", date: "Some date i dont give a fuck", isDone: true),
                            TasksCollectionViewCellData(id: 8, title: "Task 8", subtitle: "Subtitle task 8 long long long", date: "Some date i dont give a fuck", isDone: false)
    ]
}

//MARK: - TaskEntityProtocol
extension TaskEntity: TaskEntityProtocol {
    
    func getTaskViewData() -> TaskViewData {
        TaskViewData(title: title, date: currentDate, buttonTitle: buttonTitle, allButtonTitle: allButton, openButtonTitle: openButton, closedButtonTitle: closedButton)
    }

    func getTasks() -> [TasksCollectionViewCellData] {
        testTasks
    }

    func toggleIsDone(_ id: Int) {
        guard let index = (testTasks.firstIndex { $0.id == id }) else { return }
        testTasks[index].isDone.toggle()
    }

}

//MARK: - TaskViewData
struct TaskViewData {
    let title: String
    let date: String
    let buttonTitle: String
    let allButtonTitle: FilterButtonData
    let openButtonTitle: FilterButtonData
    let closedButtonTitle: FilterButtonData
}

//MARK: - TasksCollectionViewCellData
struct TasksCollectionViewCellData {
    let id: Int
    let title: String
    let subtitle: String
    let date: String
    var isDone: Bool
}

//MARK: - FilterButtonData
struct FilterButtonData {
    let title: String
    let number: String
    let isSelected: Bool
}
