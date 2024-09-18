import Foundation
import CoreData


extension TaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var date: String?
    @NSManaged public var isComplited: Bool

}

extension TaskModel : Identifiable {

    func updateIsComplited() {
        self.isComplited.toggle()

        try! managedObjectContext?.save()
    }

    func update(_ task: TaskModel) {
        self.title = task.title
        self.subtitle = task.subtitle

        try! managedObjectContext?.save()
    }

    func remove() {
        managedObjectContext?.delete(self)

        try! managedObjectContext?.save()
    }

}
