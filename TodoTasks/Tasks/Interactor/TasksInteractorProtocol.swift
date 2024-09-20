import Foundation

protocol TasksInteractorProtocol: AnyObject {
    var presenter: TasksPresenterInteractorProtocol? { get set }

    func getTasks()
    func getTaskViewData()
    func handleEvent(_ event: TasksEvent)
}
