import Foundation

protocol TasksViewControllerProtocol: AnyObject {
    func setTasks(_ tasks: [TasksCollectionViewCellData])
    func setTitle(_ text: String)
    func setDate(_ text: String)
    func setAddNewTaskButton(_ text: String)
    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData)
    func setDoneButtonAction(_ doneButtonAction: @escaping ((Int) -> ()))
    func setFilterAction(_ filterAction: @escaping ((TaskFilterType) -> ()))
    func setRemoveTaskAction(_ removeTaskAction: @escaping ((Int) -> ()))
}
