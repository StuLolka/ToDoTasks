import Foundation

//MARK: - TasksPresenterProtocol
protocol TasksPresenterProtocol: TasksPresenterViewProtocol, TasksPresenterInteractorProtocol {}

//MARK: - TasksPresenterViewProtocol
protocol TasksPresenterViewProtocol: AnyObject {
    var interactor: TasksInteractorProtocol? { get set }

    func configureView()
    func updateTasks()
}

//MARK: - TasksPresenterInteractorProtocol
protocol TasksPresenterInteractorProtocol: AnyObject {
    func setTasks(_ tasks: [TaskModel])
    func setTaskViewData(_ taskViewData: TasksViewData)
    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData)
    func presentCreateTaskView()
    func presentEditTaskView(taskModel: TaskModel?)
}

//MARK: - TasksPresenterDelegateProtocol
protocol TasksPresenterDelegateProtocol {
    func sendEvent(_ event: TasksEvent)
}
