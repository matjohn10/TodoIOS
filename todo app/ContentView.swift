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
    @State var todos: [String] = ["Eat lunch", "Write code", "Write my essay about war time Cold war shit"]
    @State var testToDo: [String] = UserDefaults.standard.array(forKey: "mytodos") as? [String] ?? []
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
                TextField("Add here...", text: $input).padding()
                Button("Add") {
                    if !self.input.isEmpty {
                        //self.todos += testToDo
                        self.testToDo.append(self.input)
                        UserDefaults.standard.set(self.testToDo, forKey: "mytodos")
                        self.input = ""
                        self.testToDo = UserDefaults.standard.array(forKey: "mytodos") as? [String] ?? []
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
                VStack(alignment: .leading) {
                    ForEach(self.testToDo, id: \.self) { item in
                        HStack {
                            Text(item.capitalized)
                                
                            Spacer()
                            Button {
                                self.testToDo = self.testToDo.filter({$0 != item})
                                UserDefaults.standard.set(self.testToDo, forKey: "mytodos")
                            } label: {
                                Image(systemName: "xmark.circle.fill")
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
