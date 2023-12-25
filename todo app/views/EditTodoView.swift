//
//  EditTodoView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-24.
//

import SwiftUI
import CoreData

struct EditTodoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var todo: FetchedResults<Todos>.Element
    @State var title = ""
    @State var content = ""
    @State var dueDate: Date = Date()
    
    var body: some View {
        Form {
            Section {
                Text("Task Editor").font(.largeTitle).bold()
                TextField("\(todo.title!)", text: $title)
                    .onAppear {
                        title = todo.title!
                    }
                TextField("\(todo.content!)", text: $content)
                    .onAppear {
                        content = todo.content!
                    }
                DatePicker(selection: Binding(projectedValue: $dueDate), label: { Text("Due Date") })
                    .onAppear {
                        dueDate = todo.due_date!
                    }
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editTodo(todo: todo, title: title, content: content, due: dueDate, context: managedObjContext)
                        dismiss()
                    }
                    .padding()
                    .background(.secondaryBg)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .bold()
                    Spacer()
                }
            }
        }
    }
}

