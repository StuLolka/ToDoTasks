import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getTasks() -> [TasksCollectionViewCellData]
    func saveTasks()
    func getTaskViewData() -> TaskViewData
    func toggleIsDone(_ id: Int)
}
