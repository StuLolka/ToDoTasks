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

    func setTitle(_ text: String) {
        mainView.setTitle(text)
    }
    
    func setDate(_ text: String) {
        mainView.setDate(text)
    }
    
    func setAddNewTaskButton(_ text: String) {
        mainView.setAddNewTaskButton(text)
    }

    func setTasks(_ tasks: [TasksCollectionViewCellData]) {
        mainView.reloadTasks(tasks)
    }

    func setButtonsData(allButtonData: FilterButtonData, openButtonData: FilterButtonData, closedButtonData: FilterButtonData) {
        mainView.setButtonsData(allButtonData: allButtonData, openButtonData: openButtonData, closedButtonData: closedButtonData)
    }

    func setDoneButtonAction(_ doneButtonAction: @escaping ((Int) -> ())) {
        mainView.doneButtonAction = doneButtonAction
    }

    func setFilterAction(_ filterAction: @escaping ((TaskFilterType) -> ())) {
        mainView.filterAction = filterAction
    }


}
