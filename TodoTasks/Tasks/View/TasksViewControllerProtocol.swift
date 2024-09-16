import Foundation

protocol TasksViewControllerProtocol: AnyObject {
    func setTasks(_ tasks: [TasksCollectionViewCellData])
    func setData(_ data: TaskViewData, _ doneButtonAction: @escaping ((Int) -> ()))
}
