import Foundation

class TasksPresenter {

    var router: TasksRouterProtocol = TasksRouter()
    var interactor: TasksInteractorProtocol!
    weak var view: TasksViewControllerProtocol!

    private var taskViewData: TaskViewData {
        interactor.getTaskViewData()
    }

    init(view: TasksViewControllerProtocol) {
        self.view = view
    }
    
}

extension TasksPresenter: TasksPresenterProtocol {

    func reloadTasks() {
        view.setTasks(interactor.getTasks())
    }

    func configureView() {
        view.setTasks(interactor.getTasks())
        view.setData(taskViewData, interactor.toggleIsDone)
    }
    
    func addNewTask() {}
    
    func editTask() {}
    
    func removeTask() {}

}
