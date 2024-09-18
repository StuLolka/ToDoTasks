import UIKit

protocol TasksViewProtocol: UIView {
    var delegate: TasksPresenterDelegateProtocol? { get set }

    func reloadTasks(_ tasks: [TaskModel])
    func setTitle(_ text: String)
    func setDate(_ text: String)
    func setAddNewTaskButton(_ text: String)
    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData)

}
