//
//  todo_appApp.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-22.
//

import SwiftUI

@main
struct todo_appApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
