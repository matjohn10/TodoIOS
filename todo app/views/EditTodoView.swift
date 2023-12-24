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
    
    @Binding var todo: String
    
    var body: some View {
        Text(todo)
    }
}

