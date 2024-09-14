import Foundation

class TasksPresenter {

    var router: TasksRouterProtocol = TasksRouter()
    var interactor: TasksInteractorProtocol!
    weak var view: TasksViewControllerProtocol!

    private var taskViewDataSource: TaskViewDataSource {
        interactor.getTaskViewDataSource()
    }

    init(view: TasksViewControllerProtocol) {
        self.view = view
    }

    
}

extension TasksPresenter: TasksPresenterProtocol {

    func configureView() {
        view.setTasks()
        view.setData(taskViewDataSource)
    }
    
    func addNewTask() {
        
    }
    
    func editTask() {
        
    }
    
    func removeTask() {
        
    }

}
