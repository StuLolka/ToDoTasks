import Foundation

protocol TasksPresenterProtocol: AnyObject {
    var router: TasksRouterProtocol { set get }

    func configureView()
    func addNewTask()
    func editTask()
    func removeTask()
}
