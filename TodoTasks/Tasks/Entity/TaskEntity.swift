import Foundation

class TaskEntity {

    var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        return dateFormatter.string(from: date)
    }

    let title = "Today's Task"
    let buttonTitle = "New Task"
    private var selectedFilter = TaskFilterType.all

    private var testTasks = [TasksCollectionViewCellData(id: 1, title: "Task 1", subtitle: "Subtitle task 1", date: "Some date", isDone: false),
                            TasksCollectionViewCellData(id: 2, title: "Task 2", subtitle: "Subtitle task 2", date: "Some date", isDone: true),
                            TasksCollectionViewCellData(id: 3, title: "Task 3", subtitle: "Subtitle task 3 tratatatat", date: "Some date", isDone: true),
                            TasksCollectionViewCellData(id: 4, title: "Task 4", subtitle: "Subtitle task 4 long long long", date: "Some date", isDone: false),
                            TasksCollectionViewCellData(id: 5, title: "Task 5", subtitle: "Subtitle task 5", date: "Some date", isDone: false),
                            TasksCollectionViewCellData(id: 6, title: "Task 6", subtitle: "Subtitle task 6", date: "Some date", isDone: true),
                            TasksCollectionViewCellData(id: 7, title: "Task 7", subtitle: "Subtitle task 7 tratatatat", date: "Some date", isDone: true),
                            TasksCollectionViewCellData(id: 8, title: "Task 8", subtitle: "Subtitle task 8 long long long", date: "Some date", isDone: false)
    ]

    private var openTasks: [TasksCollectionViewCellData] {
        testTasks.filter { !$0.isDone }
    }

    private var closedTasks: [TasksCollectionViewCellData] {
        testTasks.filter { $0.isDone }
    }
}

//MARK: - TaskEntityProtocol
extension TaskEntity: TaskEntityProtocol {

    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData) {
        let allButton = FilterButtonData(title: "All", number: String(testTasks.count), isSelected: selectedFilter == .all)
        let openButton = FilterButtonData(title: "Open", number: String(openTasks.count), isSelected: selectedFilter == .open)
        let closedButton = FilterButtonData(title: "Closed", number: String(closedTasks.count), isSelected: selectedFilter == .closed)
        return (allButton, openButton, closedButton)
    }

    func getTaskViewData() -> TaskViewData {
        let allButton = FilterButtonData(title: "All", number: String(testTasks.count), isSelected: true)
        let openButton = FilterButtonData(title: "Open", number: String(openTasks.count), isSelected: false)
        let closedButton = FilterButtonData(title: "Closed", number: String(closedTasks.count), isSelected: false)
        return TaskViewData(title: title, date: currentDate, buttonTitle: buttonTitle, allButtonData: allButton, openButtonData: openButton, closedButtonData: closedButton)
    }

    func getTasks() -> [TasksCollectionViewCellData] {
        switch selectedFilter {
        case .all: return testTasks
        case .open: return openTasks
        case .closed: return closedTasks
        }
    }

    func changeSelectedFilter(to filter: TaskFilterType) {
        selectedFilter = filter
    }

    func toggleIsDone(_ id: Int) {
        guard let index = (testTasks.firstIndex { $0.id == id }) else { return }
        testTasks[index].isDone.toggle()
    }

    func setTasksFromService(_ tasks: [TasksCollectionViewCellData]) {
        self.testTasks = tasks
    }

}

//MARK: - TaskViewData
struct TaskViewData {
    let title: String
    let date: String
    let buttonTitle: String
    let allButtonData: FilterButtonData
    let openButtonData: FilterButtonData
    let closedButtonData: FilterButtonData
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


//MARK: - FilterButtonType
enum TaskFilterType {
    case all
    case open
    case closed
}
