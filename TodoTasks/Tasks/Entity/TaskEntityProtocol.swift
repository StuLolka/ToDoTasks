import Foundation

protocol TaskEntityProtocol {
    func getTask(id: UUID) -> TaskModel?
    func getTaskViewData() -> TaskViewData
    func getTasks() -> [TaskModel]
    func toggleIsDone(_ id: UUID)
    func changeSelectedFilter(to filter: TaskFilterType)
    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData)
    func setTasksFromService(_ tasks: TaskServerModel)
    func removeTask(_ id: UUID)
}
