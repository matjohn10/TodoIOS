//
//  ListView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-24.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: []) var lists: FetchedResults<TodoList>
    @Environment(\.dismiss) var dismiss
    
    @Binding var todoList: Int32
    @Binding var todolistName: String
    
    var body: some View {
            List {
                
                Button {
                    todoList = 0
                    todolistName = "OnTrack"
                    dismiss()
                } label: {
                    Label("OnTrack", systemImage: "arrowshape.turn.up.left").foregroundColor(.orange)
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
                .tint(.orange)
                
                ForEach(lists) {list in
                    Button (list.name!) {
                        todoList = list.id
                        todolistName = list.name!
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
            }.listStyle(PlainListStyle()).navigationTitle("Tracking Lists")
        
    }
}

