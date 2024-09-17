import Foundation

class TasksPresenter {

    var router: TasksRouterProtocol = TasksRouter()
    var interactor: TasksInteractorProtocol!
    weak var view: TasksViewControllerProtocol!

    private var currentDate: String {
        interactor.getCurrentDate()
    }

    private var title: String {
        interactor.getTitle()
    }

    private var buttonTitle: String {
        interactor.getButtonTitle()
    }

    private var taskViewData: TaskViewData {
        interactor.getTaskViewData()
    }

    init(view: TasksViewControllerProtocol) {
        self.view = view
    }
    
}

//MARK: - TasksPresenterProtocol
extension TasksPresenter: TasksPresenterProtocol {

    func setTasks(_ tasks: [TasksCollectionViewCellData]) {
        view.setTasks(tasks)
    }

    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData) {
        view.setButtonsData(allButtonData: all, openButtonData: open, closedButtonData: closed)
    }

    func configureView() {
        interactor.getTasks()

        view.setTitle(title)
        view.setDate(currentDate)
        view.setAddNewTaskButton(interactor.getButtonTitle())
        view.setDelegate(self)
    }

    func eventHandler() {
        
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
