//
//  ContentView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.due_date, order: .forward)]) var todos: FetchedResults<Todos>
    
    @State var addViewShow: Bool = false
    @State var changeListShow: Bool = false
    
    @State var todoList: Int32 = 0
    @State var todolistName: String = "OnTrack"
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                HStack {
                    Text("\(tasksDueToday()) due today!")
                        .padding(.horizontal)
                    if tasksDueToday() == 0 {
                        Image(systemName: "flag.checkered").foregroundColor(.orange)
                    } else {
                        Image(systemName: "alarm.waves.left.and.right.fill").foregroundColor(.orange)
                    }
                }
                
                List {
                    ForEach(todos) { todo in
                        NavigationLink(destination: EditTodoView(todo: todo)) {
                            HStack {
                                VStack (alignment: .leading, spacing: 4.0) {
                                    Text(todo.title!).bold()
                                    Text(todo.content!)
                                }
                                Spacer()
                                Text(TimeFormat(date: todo.due_date!))
                            }
                            
                        }
                        .padding()
                        .background(Color.secondaryBg)
                        .cornerRadius(15.0)
                    }
                    .onDelete(perform: deleteTodo)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            // TODO: Add to done tasks
                            print("complete")
                        } label: {
                            Label("Complete", systemImage: "checkmark.circle")
                        }
                        .tint(.green)
                    }
                }.listStyle(PlainListStyle())

            }
            .navigationTitle(todolistName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Menu {
                        Button {
                            addViewShow.toggle()
                        } label: {
                            Label("Add Task", systemImage: "plus.circle")
                        }
                        Button {
                            changeListShow.toggle()
                        } label: {
                            Label("Change List", systemImage: "square.stack")
                        }
                        Button {
                            print("Edit Page")
                        } label: {
                            Label("Edit", systemImage: "slider.horizontal.2.square")
                        }
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                    }
                    .tint(.orange)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton().foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $addViewShow) {
                AddTodoView()
            }
            .sheet(isPresented: $changeListShow) {
                ListView(todoList: $todoList, todolistName: $todolistName)
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    private func deleteTodo(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    
    private func tasksDueToday() -> Int {
        var count = 0
        for todo in todos {
            if Calendar.current.isDateInToday(todo.due_date!) {
                count += 1
            }
        }
        return count
    }
}


#Preview {
    ContentView()
}
