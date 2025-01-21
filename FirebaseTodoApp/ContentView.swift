//
//  ContentView.swift
//  FirebaseTodoApp
//
//  Created by user268114 on 1/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var todos: [TodoApp] = []
    @State private var showAddTodoSheet = false

    private let firestoreService = FirestoreService()

    var body: some View {
        NavigationView {
            VStack {
                if todos.isEmpty {
                    Text("No Todos Yet")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(todos) { todo in
                        HStack {
                            Text(todo.title)
                                .strikethrough(todo.isDone, color: .gray)
                            Spacer()
                            Button(action: {
                                toggleTodoCompletion(todo)
                            }) {
                                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.isDone ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTodoSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                loadTodos()
            }
            .sheet(isPresented: $showAddTodoSheet) {
                AddToDo { newTodo in
                    addTodo(newTodo)
                }
            }
        }
    }

    private func loadTodos() {
        firestoreService.fetchTodos { fetchedTodos, error in
            if let fetchedTodos = fetchedTodos {
                todos = fetchedTodos
            } else if let error = error {
                print("Error fetching Todos: \(error)")
            }
        }
    }

    private func addTodo(_ newTodo: TodoApp) {
        firestoreService.addTodo(newTodo) { error in
            if let error = error {
                print("Error adding Todo: \(error)")
            } else {
                todos.append(newTodo)
            }
        }
    }

    private func toggleTodoCompletion(_ todo: TodoApp) {
        var updatedTodo = todo
        updatedTodo.isDone.toggle()
        firestoreService.updateTodo(updatedTodo) { error in
            if let error = error {
                print("Error updating Todo: \(error)")
            } else {
                if let index = todos.firstIndex(where: { $0.id == updatedTodo.id }) {
                    todos[index] = updatedTodo
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
