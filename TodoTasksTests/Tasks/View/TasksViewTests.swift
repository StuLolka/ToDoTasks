import XCTest
@testable import TodoTasks

final class TasksViewTests: XCTestCase {

    private let view: TasksViewProtocol = TasksView()
    private let viewController: TasksViewControllerProtocol = TasksViewController()
    private lazy var router: TasksRouterProtocol = TasksRouter(viewController: viewController)
    private lazy var delegate: TasksPresenterDelegateProtocol = TasksPresenter(viewController: viewController, router: router)

    override func setUpWithError() throws {
        try super.setUpWithError()
        view.delegate = delegate
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testViewControllerDelegate() throws {
        XCTAssertNotNil(view.delegate)
    }

}
