import Foundation

protocol TaskEntityProtocol {
    var currentDate: String { get }
    var title: String { get }
    var buttonTitle: String { get }

    func getTaskViewData() -> TaskViewData
    func getTasks() -> [TasksCollectionViewCellData]
    func toggleIsDone(_ id: Int)
    func changeSelectedFilter(to filter: TaskFilterType)
    func getButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData)
    func setTasksFromService(_ tasks: [TasksCollectionViewCellData])
    func removeTask(_ id: Int)
}
