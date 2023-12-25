//
//  DataController.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TodoModel")
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }}
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        }
        catch {
            print("Could not save data...")
        }
    }
    
    func addTodo(title: String, content: String, due: Date, list: Int32 = 0, context: NSManagedObjectContext) {
        let todo = Todos(context: context)
        todo.id = UUID()
        todo.title = title
        todo.content = content
        todo.date = Date()
        todo.list_id = list
        todo.due_date = due
        
        save(context: context)
    }
    
    func editTodo(todo: Todos, title: String, content: String, due: Date, context: NSManagedObjectContext) {
        todo.date = Date()
        todo.title = title
        todo.content = content
        todo.due_date = due
        save(context: context)
    }
}
