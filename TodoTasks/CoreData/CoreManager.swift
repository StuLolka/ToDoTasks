import CoreData

class CoreManager {
    
    static let shared = CoreManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var context = persistentContainer.viewContext


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

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

        try! context.save()
    }
    

    func saveTask(_ task: EditTaskData) {
        let newTask = TaskModel(context: context)
        newTask.id = UUID()
        newTask.title = task.title
        newTask.subtitle = task.subtitle
        newTask.isComplited = false
        newTask.date = Date()

        try! context.save()
    }

}
