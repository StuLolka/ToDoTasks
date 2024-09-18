import UIKit

class TasksRouter {

    unowned var viewController: TasksViewControllerProtocol

    init(viewController: TasksViewControllerProtocol) {
        self.viewController = viewController
    }

}

extension TasksRouter: TasksRouterProtocol {

    func presentAddNewTaskViewController() {
        let editTaskViewController = EditTaskViewController()
        editTaskViewController.routerDelegate = self
        viewController.present(editTaskViewController, animated: true)
    }

}

extension TasksRouter: TasksRouterDelegateProtocol {

    func viewWillDisappear() {
        viewController.updateTasks()
    }

}
