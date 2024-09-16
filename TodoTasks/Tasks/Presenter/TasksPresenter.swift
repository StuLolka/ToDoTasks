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

    private var buttonsData: (FilterButtonData, FilterButtonData, FilterButtonData) {
        interactor.getFilterButtonsData()
    }

    init(view: TasksViewControllerProtocol) {
        self.view = view
    }
    
}

//MARK: - TasksPresenterProtocol
extension TasksPresenter: TasksPresenterProtocol {

    func reloadTasks(_ tasks: [TasksCollectionViewCellData]) {
        view.setTasks(tasks)
        view.setButtonsData(allButtonData: buttonsData.0, openButtonData: buttonsData.1, closedButtonData: buttonsData.2)
    }

    func configureView() {
        interactor.getTasks()

        view.setTitle(title)
        view.setDate(currentDate)
        view.setAddNewTaskButton(interactor.getButtonTitle())
        view.setButtonsData(allButtonData: buttonsData.0, openButtonData: buttonsData.1, closedButtonData: buttonsData.2)
        view.setDoneButtonAction(interactor.toggleIsDone(_:))
        view.setFilterAction(interactor.filterTask(type:))
    }
    
    func addNewTask() {}
    
    func editTask() {}
    
    func removeTask() {}

}
