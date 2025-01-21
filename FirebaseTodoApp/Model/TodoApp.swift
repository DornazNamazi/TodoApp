//
//  TodoApp.swift
//  FirebaseTodoApp
//
//  Created by user268114 on 1/17/25.
//

import Foundation


struct TodoApp: Identifiable, Codable{
    var id: String = UUID().uuidString
    var title: String
    var isDone: Bool
}
