import UIKit

class TasksViewController: UIViewController {

    var presenter: TasksPresenterProtocol?

    private let configurator: TasksConfiguratorProtocol = TasksConfigurator()
    private let mainView: TasksViewProtocol = TasksView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
    }

}

//MARK: - TasksViewControllerProtocol
extension TasksViewController: TasksViewControllerProtocol {

    func setTasks(_ tasks: [TasksCollectionViewCellData]) {
        mainView.reloadTasks(tasks)
    }

    func setData(_ data: TaskViewData,  _ doneButtonAction: @escaping ((Int) -> ())) {
        mainView.setData(data, doneButtonAction)
    }

}
