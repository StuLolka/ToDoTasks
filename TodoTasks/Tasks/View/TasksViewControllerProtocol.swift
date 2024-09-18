import UIKit

protocol TasksViewControllerProtocol: UIViewController {
    func updateTasks()
    func setTasks(_ tasks: [TaskModel])
    func setTitle(_ text: String)
    func setDate(_ text: String)
    func setAddNewTaskButton(_ text: String)
    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData)
    func setDelegate(_ delegate: TasksPresenterDelegateProtocol)
}
