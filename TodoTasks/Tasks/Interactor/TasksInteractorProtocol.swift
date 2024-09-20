import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getTasks()
    func getTaskViewData()
    func handleEvent(_ event: TasksEvent)
}
