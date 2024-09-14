import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func downloadTasks()
    func saveTasks()
    func getTaskViewDataSource() -> TaskViewDataSource
}
