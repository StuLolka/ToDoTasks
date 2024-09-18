import Foundation

class EditTaskEntity {

    private let cancelButtonTitle = "Cancel"
    private let doneButtonTitle = "Done"
    private let titlePlaceholder = "Title"
    private let subtitlePlaceholder = "Notes"
    
}

//MARK: - EditTaskEntityProtocol
extension EditTaskEntity: EditTaskEntityProtocol {

    func getEditTaskEntityData() -> EditTaskEntityData {
        return EditTaskEntityData(cancelButtonTitle: cancelButtonTitle, doneButtonTitle: doneButtonTitle,
                                  titlePlaceholder: titlePlaceholder, subtitlePlaceholder: subtitlePlaceholder)
    }

    func saveTask(_ task: EditTaskData) {
        CoreManager.shared.saveTask(task)
    }

}

//MARK: - EditTaskEntityData
struct EditTaskEntityData {
    let cancelButtonTitle: String
    let doneButtonTitle: String
    let titlePlaceholder: String
    let subtitlePlaceholder: String
}

//MARK: - EditTaskData
struct EditTaskData {
    let title: String
    let subtitle: String
}
