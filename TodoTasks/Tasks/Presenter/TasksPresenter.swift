import Foundation

class TasksPresenter {

    var interactor: TasksInteractorProtocol!
    weak var viewController: TasksViewControllerProtocol!

    private let router: TasksRouterProtocol

    private var taskViewData: TaskViewData {
        interactor.getTaskViewData()
    }

    init(viewController: TasksViewControllerProtocol, router: TasksRouterProtocol) {
        self.viewController = viewController
        self.router = router
    }
    
}

//MARK: - TasksPresenterViewProtocol
extension TasksPresenter: TasksPresenterViewProtocol {

    func configureView() {
        interactor.getTasks()

        viewController.setTitle(taskViewData.title)
        viewController.setDate(taskViewData.date)
        viewController.setAddNewTaskButton(taskViewData.buttonTitle)
        viewController.setDelegate(self)
    }

    func updateTasks() {
        interactor.getTasks()
    }

}

//MARK: - TasksPresenterProtocol
extension TasksPresenter: TasksPresenterProtocol {

    func setTasks(_ tasks: [TaskModel]) {
        viewController.setTasks(tasks)
    }

    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData) {
        viewController.setButtonsData(allButtonData: all, openButtonData: open, closedButtonData: closed)
    }

    func eventHandler() {
        
    }

    func presentCreateTaskView() {
        router.presentAddNewTaskViewController()
    }
    
    func addNewTask() {}
    
    func editTask() {}
    
    func removeTask() {}

}

//MARK: - TasksPresenterDelegateProtocol
extension TasksPresenter: TasksPresenterDelegateProtocol {
    
    func sendEvent(_ event: TasksEvent) {
        interactor.handleEvent(event)
    }

}
