import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getTasks()
    func saveTasks()
    func getTaskViewData() -> TaskViewData
    func handleEvent(_ event: TasksEvent)
}
