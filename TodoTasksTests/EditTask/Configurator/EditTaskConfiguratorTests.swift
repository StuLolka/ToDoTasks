import XCTest
@testable import TodoTasks

final class EditTaskConfiguratorTests: XCTestCase {

    private let viewController: EditTaskViewControllerProtocol = EditTaskViewController(mode: .createTask)
    private let interactor: EditTaskInteractorProtocol = EditTaskInteractor(mode: .createTask)
    private lazy var router: EditTaskRouterProtocol = EditTaskRouter(viewController: viewController)
    private lazy var presenter: EditTaskPresenterProtocol = EditTaskPresenter(viewController: viewController, router: router)

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
