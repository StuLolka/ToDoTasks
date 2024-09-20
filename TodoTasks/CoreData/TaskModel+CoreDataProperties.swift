import Foundation
import CoreData


extension TaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String!
    @NSManaged public var subtitle: String!
    @NSManaged public var date: Date!
    @NSManaged public var isComplited: Bool

}

extension TaskModel : Identifiable {

    func updateIsComplited() {
        self.isComplited.toggle()

        do {
            guard let managedObjectContext else {
                Logger.shared.printLog(.foundNil("managedObjectContext"))
                return
            }
            try managedObjectContext.save()
        }
        catch(let error) {
            Logger.shared.printLog(.contextError(error.localizedDescription))
        }
    }

    func update(_ task: EditTaskData) {
        self.title = task.title
        self.subtitle = task.subtitle

        do {
            guard let managedObjectContext else {
                Logger.shared.printLog(.foundNil("managedObjectContext"))
                return
            }
            try managedObjectContext.save()
        }
        catch(let error) {
            Logger.shared.printLog(.contextError(error.localizedDescription))
        }
    }

    func remove() {
        guard let managedObjectContext else {
            Logger.shared.printLog(.foundNil("managedObjectContext"))
            return
        }
        managedObjectContext.delete(self)

        do {
            try managedObjectContext.save()
        }
        catch(let error) {
            Logger.shared.printLog(.contextError(error.localizedDescription))
        }
    }

}
