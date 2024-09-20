import XCTest
@testable import TodoTasks

final class EditTaskViewTests: XCTestCase {

    private let view: EditTaskViewProtocol = EditTaskView()
    private let viewController: EditTaskViewControllerProtocol = EditTaskViewController(mode: .createTask)
    private lazy var router: EditTaskRouterProtocol = EditTaskRouter(viewController: viewController)
    private lazy var delegate: EditTaskPresenterDelegateProtocol = EditTaskPresenter(viewController: viewController, router: router)

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
