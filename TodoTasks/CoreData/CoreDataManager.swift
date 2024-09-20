import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.shared.printLog(.foundNil(error.localizedDescription))
            }
        })
        return container
    }()

    private lazy var context = persistentContainer.viewContext

    func getTasks() -> [TaskModel] {
        let request = TaskModel.fetchRequest()

        if let tasks = try? persistentContainer.viewContext.fetch(request) {
            return tasks
        }
        return []
    }

    func saveTaskFromServer(_ task: Todos) {
        let newTask = TaskModel(context: context)
        newTask.id = UUID()
        newTask.title = task.todo
        newTask.subtitle = task.todo
        newTask.isComplited = task.completed
        newTask.date = Date()

        do {
            try context.save()
        }
        catch(let error) {
            Logger.shared.printLog(.contextError(error.localizedDescription))
        }
    }
    

    func saveTask(_ task: EditTaskData) {
        let newTask = TaskModel(context: context)
        newTask.id = UUID()
        newTask.title = task.title
        newTask.subtitle = task.subtitle
        newTask.isComplited = false
        newTask.date = Date()

        do {
            try context.save()
        }
        catch(let error) {
            Logger.shared.printLog(.contextError(error.localizedDescription))
        }
    }

}
