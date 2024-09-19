import UIKit

class TasksRouter {

    unowned var viewController: TasksViewControllerProtocol

    init(viewController: TasksViewControllerProtocol) {
        self.viewController = viewController
    }

}

//MARK: - TasksRouterProtocol
extension TasksRouter: TasksRouterProtocol {

    func presentAddNewTaskViewController() {
        let editTaskViewController = EditTaskViewController(mode: .createTask)
        editTaskViewController.routerDelegate = self
        viewController.present(editTaskViewController, animated: true)
    }

    func presentEditTaskViewController(_ data: TaskModel) {
        let editTaskViewController = EditTaskViewController(mode: .editTask(data))
        editTaskViewController.routerDelegate = self
        viewController.present(editTaskViewController, animated: true)
    }
    
}

//MARK: - TasksRouterDelegateProtocol
extension TasksRouter: TasksRouterDelegateProtocol {

    func viewWillDisappear() {
        viewController.updateTasks()
    }

}
