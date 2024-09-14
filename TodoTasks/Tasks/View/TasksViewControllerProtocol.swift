import Foundation

protocol TasksViewControllerProtocol: AnyObject {
    func setTasks()
    func setData(_ data: TaskViewDataSource)
}
