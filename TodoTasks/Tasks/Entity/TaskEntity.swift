import Foundation

class TaskEntity {

    private var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        return dateFormatter.string(from: date)
    }

    private let title = "Today's Task"
    private let buttonTitle = "New Task"
    private let allButton = FilterButtonDataSource(title: "All", number: "0", isSelected: true)
    private let openButton = FilterButtonDataSource(title: "Open", number: "0", isSelected: false)
    private let closedButton = FilterButtonDataSource(title: "Closed", number: "0", isSelected: false)

}

extension TaskEntity: TaskEntityProtocol {
    
    func getTaskViewDataSource() -> TaskViewDataSource {
        TaskViewDataSource(title: title, date: currentDate, buttonTitle: buttonTitle, allButtonTitle: allButton, openButtonTitle: openButton, closedButtonTitle: closedButton)
    }

}
