import Foundation

protocol FilterButtonDelegate: AnyObject {
    func buttonTapped(_ type: TasksFilterType)
}
