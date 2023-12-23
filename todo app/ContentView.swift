//
//  ContentView.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-22.
//

import SwiftUI

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
                Text("OnTrack").font(.largeTitle).bold().padding()
                Button("Start") {
                    self.start = true
                }.foregroundColor(.black).font(.title2)
                Spacer()
            }
        }
    }
}

struct MenuView: View {
    @Binding var start: Bool
    @State var todos: [String] = ["Eat lunch", "Write code"]
    @State var input = ""
    var body: some View {
        VStack {
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
                TextField("Add here...", text: $input).padding()
                Button("Add") {
                    if !self.input.isEmpty {
                        self.todos.append(self.input)
                        self.input = ""
                    }
                }.padding().foregroundColor(.black)
            }
            VStack(alignment: .trailing) {
                ForEach(self.todos, id: \.self) { item in
                    Text(item.capitalized)
                        .padding()
                        .bold()
                }
            }.padding()
            Spacer()
        }
    }
    
}

#Preview {
    ContentView()
}
