import UIKit

protocol TasksViewProtocol: UIView {
    func reloadTasks(_ tasks: [TasksCollectionViewCellData])
    func setData(_ data: TaskViewData, _ doneButtonAction: @escaping ((Int) -> ()))
}
