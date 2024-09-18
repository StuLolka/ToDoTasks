import Foundation

protocol EditTaskEntityProtocol {
    func getEditTaskEntityData() -> EditTaskEntityData
    func saveTask(_ task: EditTaskData)
}
