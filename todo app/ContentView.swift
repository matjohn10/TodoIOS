//
//  ContentView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-22.
//

import SwiftUI

struct Todo: Codable {
    let id: UUID
    let name: String
    let date: Date
    
    init(name: String) {
        self.name = name
        self.id = UUID()
        self.date = Date()
    }
}

struct ContentView: View {
    @State var start = true
    
    var body: some View {
        return Group {
            if !start {
                StartView(start: $start)
            } else {
                MenuView(start: $start)
            }
        }
    }
}

struct StartView: View {
    @Binding var start: Bool
    
    
    var body: some View {
        
        ZStack {
            Color(.orange).ignoresSafeArea()
            VStack {
                Spacer()
                Text("OnTrack")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Button("Start") {
                    self.start = true
                }
                .foregroundColor(.black)
                .font(.title2)
                .fontWeight(.semibold)
                Spacer()
            }
        }
    }
}

struct MenuView: View {
    @Binding var start: Bool
    @State var testToDo: [String: [String]] = UserDefaults.standard.object(forKey: "mytodos") as? [String: [String]] ?? [:]
    @State var input = ""
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack {
                Spacer()
                Text("Your List").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().padding()
                Spacer()
                Button("Back") {
                    self.start = false
                }
                Spacer()
            }
            
            HStack {
                // Add todo
                TextField("Add here...", text: $input).padding()
                Button("Add") {
                    if !self.input.isEmpty {
                        let todo = Todo(name: self.input)
                        self.testToDo[todo.id.uuidString] = [todo.name, todo.date.ISO8601Format()]
                        
                        UserDefaults.standard.set(self.testToDo, forKey: "mytodos")
                        self.input = ""
                        self.testToDo = UserDefaults.standard.object(forKey: "mytodos") as? [String:[String]] ?? [:]
                    }
                }
                .padding()
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .background(Color.orange)
                .cornerRadius(10.0)
            }
            
            // Todo stack
            ScrollView {
                LazyVStack(alignment: .leading) {
                    // Placeholder if todos empty
                    if self.testToDo.isEmpty {
                        HStack {
                            Spacer()
                            Text("No tasks yet...")
                            Spacer()
                        }
                        
                    }
                    
                    ForEach(Array(self.testToDo).sorted(by: {$0.1[1] < $1.1[1]}).map{(k, v) in return k}, id: \.self) {
                        key in
                        HStack {
                            Text(self.testToDo[key]![0].capitalized)
                                
                            Spacer()
                            // Done button
                            Button {
                                self.testToDo.removeValue(forKey: key)
                                UserDefaults.standard.set(self.testToDo, forKey: "mytodos")
                            } label: {
                                Image(systemName: "checkmark.circle")
                            }
                            
                            
                        }
                        .padding()
                            .bold()
                            .foregroundColor(.black)
                            .background(Color.secondaryBg)
                            .cornerRadius(15.0)
                    }
                }
                .frame(
                    minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding()
            }
            
            
            Spacer()
        }.padding()
    }
    
    
    
}

#Preview {
    ContentView()
}
