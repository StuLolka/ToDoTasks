import Foundation

protocol TasksEntityProtocol {
    func getTask(id: UUID) -> TaskModel?
    func getTaskViewData() -> TasksViewData
    func getTasks() -> [TaskModel]
    func toggleIsComplited(_ id: UUID, completion: @escaping (() -> ()))
    func changeSelectedFilter(to filter: TasksFilterType, completion: @escaping (() -> ()))
    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData)
    func setTasksFromService(_ tasks: TaskServerModel, completion: @escaping (() -> ()))
    func setTasksFromCoreDara(completion: @escaping (() -> ()))
    func removeTask(_ id: UUID, completion: @escaping (() -> ()))
}
