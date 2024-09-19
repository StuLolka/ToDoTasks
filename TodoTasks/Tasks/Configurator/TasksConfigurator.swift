import Foundation

class TasksConfigurator {}

//MARK: - TasksConfiguratorProtocol
extension TasksConfigurator: TasksConfiguratorProtocol {

    func configure(with viewController: TasksViewController) {
        let interactor = TasksInteractor()
        let router = TasksRouter(viewController: viewController)
        let presenter = TasksPresenter(viewController: viewController, router: router)

        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

}
