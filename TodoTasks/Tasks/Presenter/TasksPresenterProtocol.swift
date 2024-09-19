import Foundation

//MARK: - TasksPresenterProtocol
protocol TasksPresenterViewProtocol: AnyObject {
    func configureView()
    func updateTasks()
}

//MARK: - TasksPresenterProtocol
protocol TasksPresenterProtocol: AnyObject {
    func setTasks(_ tasks: [TaskModel])
    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData)
    func presentCreateTaskView()
    func presentEditTaskView(id: UUID)
}

//MARK: - TasksPresenterDelegateProtocol
protocol TasksPresenterDelegateProtocol {
    func sendEvent(_ event: TasksEvent)
}
