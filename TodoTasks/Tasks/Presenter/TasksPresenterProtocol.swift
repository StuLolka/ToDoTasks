import Foundation

protocol TasksPresenterProtocol: AnyObject {
    var router: TasksRouterProtocol { set get }

    func setTasks(_ tasks: [TasksCollectionViewCellData])
    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData)
    func configureView()
    func addNewTask()
    func editTask()
    func removeTask()
}
