import Foundation

class TasksConfigurator {}

//MARK: - TasksConfiguratorProtocol
extension TasksConfigurator: TasksConfiguratorProtocol {

    func configure(with viewController: TasksViewControllerProtocol) {
        let interactor: TasksInteractorProtocol = TasksInteractor()
        let router: TasksRouterProtocol = TasksRouter(viewController: viewController)
        let presenter: TasksPresenterProtocol = TasksPresenter(viewController: viewController, router: router)

        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

}
