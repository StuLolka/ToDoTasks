import XCTest
@testable import TodoTasks

final class TasksEntityTests: XCTestCase {

    private var entity: TasksEntityProtocol = TasksEntity()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testFilterButtons() {
        let buttons = entity.getButtonsData()
        XCTAssertEqual(buttons.0.isSelected, true)
        XCTAssertEqual(buttons.1.isSelected, false)
        XCTAssertEqual(buttons.2.isSelected, false)

        entity.changeSelectedFilter(to: .open) {
            let buttons = self.entity.getButtonsData()
            XCTAssertEqual(buttons.0.isSelected, false)
            XCTAssertEqual(buttons.1.isSelected, true)
            XCTAssertEqual(buttons.2.isSelected, false)
        }

        entity.changeSelectedFilter(to: .closed) {
            let buttons = self.entity.getButtonsData()
            XCTAssertEqual(buttons.0.isSelected, false)
            XCTAssertEqual(buttons.1.isSelected, false)
            XCTAssertEqual(buttons.2.isSelected, true)
        }
    }

}
