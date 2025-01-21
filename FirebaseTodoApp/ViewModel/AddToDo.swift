//
//  AddToDo.swift
//  FirebaseTodoApp
//
//  Created by user268114 on 1/20/25.
//

import SwiftUI

struct AddToDo: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    let onSave: (TodoApp) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Todo")) {
                    TextField("Enter Todo Title", text: $title)
                }
            }
            .navigationTitle("Add Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newTodo = TodoApp(title: title, isDone: false)
                        onSave(newTodo)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

