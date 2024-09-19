import UIKit

class TasksPresenter {

    var interactor: TasksInteractorProtocol!
    weak var viewController: TasksViewControllerProtocol!

    private let router: TasksRouterProtocol
    private var taskViewData: TaskViewData {
        interactor.getTaskViewData()
    }

    init(viewController: TasksViewControllerProtocol, router: TasksRouterProtocol) {
        self.viewController = viewController
        self.router = router
    }

}

//MARK: - TasksPresenterViewProtocol
extension TasksPresenter: TasksPresenterViewProtocol {

    func configureView() {
        interactor.getTasks()

        viewController.setTitle(taskViewData.title)
        viewController.setDate(taskViewData.date)
        viewController.setAddNewTaskButton(taskViewData.buttonTitle)
        viewController.setDelegate(self)
    }

    func updateTasks() {
        interactor.getTasks()
    }

}

//MARK: - TasksPresenterProtocol
extension TasksPresenter: TasksPresenterProtocol {

    func setTasks(_ tasks: [TaskModel]) {
        let tasks = tasks.map {
            TasksCollectionViewCellData(id: $0.id, title: $0.title!, attributeString: getLabelAttribute(titleText: $0.title!, isComplited: $0.isComplited), subtitle: $0.subtitle!, date: $0.date?.transformDate() ?? "", doneButtonImage: getButtonImage(isComplited: $0.isComplited), tintColorButton: getButtonTint(isComplited: $0.isComplited))
        }
        viewController.setTasks(tasks)
    }

    func setFilterButtons(_ all: FilterButtonData, _ open: FilterButtonData, _ closed: FilterButtonData) {
        viewController.setButtonsData(allButtonData: all, openButtonData: open, closedButtonData: closed)
    }

    func presentCreateTaskView() {
        router.presentAddNewTaskViewController()
    }

    func presentEditTaskView(id: UUID)  {
        guard let taskModel = interactor.getTask(id: id) else { return }
        router.presentEditTaskViewController(taskModel)
    }

}

//MARK: - TasksPresenterDelegateProtocol
extension TasksPresenter: TasksPresenterDelegateProtocol {
    
    func sendEvent(_ event: TasksEvent) {
        interactor.handleEvent(event)
    }

}

private extension TasksPresenter {

    func getLabelAttribute(titleText: String, isComplited: Bool) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: titleText)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        let removedAttributeString = NSMutableAttributedString(string: titleText)
        removedAttributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))

        return isComplited ? attributeString : removedAttributeString
    }

    func getButtonImage(isComplited: Bool) -> UIImage {
        let imageName = isComplited ? "checkmark.circle.fill" : "circle"
        return UIImage(systemName: imageName)!
    }

    func getButtonTint(isComplited: Bool) -> UIColor {
        return isComplited ? .doneButtonTint() : .notDoneButtonTint()
    }


}
