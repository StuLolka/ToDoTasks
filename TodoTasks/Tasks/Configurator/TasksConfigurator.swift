import Foundation

class TasksConfigurator {}

//MARK: - TasksConfiguratorProtocol
extension TasksConfigurator: TasksConfiguratorProtocol {

    func configure(with viewController: TasksViewController) {
        let presenter = TasksPresenter(view: viewController)
        let interactor = TasksInteractor()
        let router = TasksRouter()

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }

}
