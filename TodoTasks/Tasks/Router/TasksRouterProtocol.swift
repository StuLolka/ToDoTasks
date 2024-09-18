import Foundation

protocol TasksRouterProtocol: AnyObject {
    func presentAddNewTaskViewController()
}

protocol TasksRouterDelegateProtocol {
    func viewWillDisappear()
}
