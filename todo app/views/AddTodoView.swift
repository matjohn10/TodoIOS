//
//  AddTodoView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-24.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var content = ""
    @State var dueDate: Date = Date()
    
    var body: some View {
            Form {
                Section {
                    Text("Task Creator").font(.largeTitle).bold()
                    TextField("Task title", text: $title)
                    TextField("Short description", text: $content)
                    DatePicker(selection: Binding(projectedValue: $dueDate), label: { Text("Due Date") })
                    
                    HStack {
                        Spacer()
                        Button("Add") {
                            DataController().addTodo(title: title, content: content, due: dueDate, context: managedObjContext)
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

#Preview {
    AddTodoView()
}
