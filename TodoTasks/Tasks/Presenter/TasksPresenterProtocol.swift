import Foundation

protocol TasksPresenterProtocol: AnyObject {
    var router: TasksRouterProtocol { set get }

    func reloadTasks(_ tasks: [TasksCollectionViewCellData])
    func configureView()
    func addNewTask()
    func editTask()
    func removeTask()
}
