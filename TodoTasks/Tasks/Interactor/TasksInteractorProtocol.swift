import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getCurrentDate() -> String
    func getTitle() -> String
    func getButtonTitle() -> String
    func getTasks()
    func saveTasks()
    func getTaskViewData() -> TaskViewData
    func handleEvent(_ event: TasksEvent)
}
