import UIKit

protocol TasksViewProtocol: UIView {
    var doneButtonAction: ((Int) -> ())? { get set }
    var filterAction: ((TaskFilterType) -> ())?  { get set }

    func reloadTasks(_ tasks: [TasksCollectionViewCellData])
    func setTitle(_ text: String)
    func setDate(_ text: String)
    func setAddNewTaskButton(_ text: String)
    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData)
}
