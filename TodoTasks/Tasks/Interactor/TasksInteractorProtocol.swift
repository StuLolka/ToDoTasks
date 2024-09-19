import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getTask(id: UUID) -> TaskModel?
    func getTasks()
    func saveTasks()
    func getTaskViewData() -> TaskViewData
    func handleEvent(_ event: TasksEvent)
}
