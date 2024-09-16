import Foundation

protocol TaskEntityProtocol {
    func getTaskViewData() -> TaskViewData
    func getTasks() -> [TasksCollectionViewCellData]
    func toggleIsDone(_ id: Int)
}
