import UIKit

protocol TasksViewControllerProtocol: UIViewController {
    var presenter: TasksPresenterViewProtocol? { get set }

    func updateTasks()
    func setTasks(_ tasks: [TasksCollectionViewCellData])
    func setTitle(_ text: String)
    func setDate(_ text: String)
    func setAddNewTaskButton(_ text: String)
    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData)
    func setDelegate(_ delegate: TasksPresenterDelegateProtocol)
}
