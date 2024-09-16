import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func getCurrentDate() -> String
    func getTitle() -> String
    func getButtonTitle() -> String
    func getTasks()
    func saveTasks()
    func getTaskViewData() -> TaskViewData
    func toggleIsDone(_ id: Int)
    func filterTask(type: TaskFilterType)
    func getFilterButtonsData() -> (FilterButtonData, FilterButtonData, FilterButtonData)
}
