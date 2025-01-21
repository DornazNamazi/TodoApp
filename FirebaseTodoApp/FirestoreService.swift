//
//  FirestoreService.swift
//  FirebaseTodoApp
//
//  Created by user268114 on 1/20/25.
//


import FirebaseFirestore

class FirestoreService {
    private let db = Firestore.firestore()
    func addTodo(_ todo: TodoApp, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "id": todo.id,
            "title": todo.title,
            "isDone": todo.isDone
        ]
        db.collection("todos").document(todo.id).setData(data) { error in
            completion(error)
        }
    }


    func fetchTodos(completion: @escaping ([TodoApp]?, Error?) -> Void) {
        db.collection("todos").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }

            var todos: [TodoApp] = []
            snapshot?.documents.forEach { document in
                let data = document.data()
                if let id = data["id"] as? String,
                   let title = data["title"] as? String,
                   let isDone = data["isDone"] as? Bool {
                    let todo = TodoApp(id: id, title: title, isDone: isDone)
                    todos.append(todo)
                }
            }
            completion(todos, nil)
        }
    }

    func updateTodo(_ todo: TodoApp, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "id": todo.id,
            "title": todo.title,
            "isDone": todo.isDone
        ]
        db.collection("todos").document(todo.id).updateData(data) { error in
            completion(error)
        }
    }

    func deleteTodo(_ id: String, completion: @escaping (Error?) -> Void) {
        db.collection("todos").document(id).delete { error in
            completion(error)
        }
    }
}
