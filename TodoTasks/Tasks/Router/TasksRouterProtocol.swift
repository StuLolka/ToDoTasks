import Foundation

//MARK: - TasksRouterProtocol
protocol TasksRouterProtocol: AnyObject {
    func presentAddNewTaskViewController()
    func presentEditTaskViewController(_ data: TaskModel)
}

//MARK: - TasksRouterDelegateProtocol
protocol TasksRouterDelegateProtocol {
    func viewWillDisappear()
}
