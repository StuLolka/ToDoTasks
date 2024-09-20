import XCTest
@testable import TodoTasks

final class TasksConfiguratorViewTests: XCTestCase {

    private let viewController: TasksViewControllerProtocol = TasksViewController()
    private let interactor: TasksInteractorProtocol = TasksInteractor()
    private lazy var router: TasksRouterProtocol = TasksRouter(viewController: viewController)
    private lazy var presenter: TasksPresenterProtocol = TasksPresenter(viewController: viewController, router: router)

    override func setUpWithError() throws {
        try super.setUpWithError()

        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testViewControllerPresenter() throws {
        XCTAssertNotNil(viewController.presenter)
    }

    func testPresenterInteractor() throws {
        XCTAssertNotNil(presenter.interactor)
    }

    func testInteractorPresenter() throws {
        XCTAssertNotNil(interactor.presenter)
    }

}
