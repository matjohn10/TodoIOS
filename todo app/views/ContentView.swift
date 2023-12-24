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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var todos: FetchedResults<Todo>
    
    @State var addViewShow: Bool = false
    
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
                        NavigationLink(destination: Text(todo.title!)) {
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
                }
                .listStyle(.plain)
            }
            .navigationTitle("OnTrack")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addViewShow.toggle()
                    } label: {
                        Image(systemName: "plus.circle").foregroundColor(.orange)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton().foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $addViewShow) {
                AddTodoView()
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    private func deleteTodo(offsets: IndexSet) {
        //pass
    }
    
    private func tasksDueToday() -> Int {
        return 0
    }
}


#Preview {
    ContentView()
}
