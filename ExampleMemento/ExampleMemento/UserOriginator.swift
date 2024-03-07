//
//  Memento.swift
//  ExampleMemento
//
//  Created by Kalandarov Vakil on 06.03.2024.
//

import Foundation

/// Memento
protocol Memento: Codable, Encodable {
    var emailTitle: String { get }
    var passwordTitle: String { get }
}

/// Model

class User: Memento {
    var emailTitle: String
    var passwordTitle: String
    
    init(emailTitle: String, passwordTitle: String) {
        self.emailTitle = emailTitle
        self.passwordTitle = passwordTitle
    }
    
}

/// Caretacer

class UserManager {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func save(users: [some Memento]) {
        do {
            let usersData = try encoder.encode(users)
            UserDefaults.standard.set(usersData, forKey: "keyMemento")
        } catch {
            print("Error")
        }
    }
    
    func load() throws ->  User {
        guard let userData = UserDefaults.standard.data(forKey: "keyMemento") as? Memento,
              let user = try decoder.decode(User.self, from: userData) else { throw Error.gameNotFound }
        return user
    }
    
    public enum Error: Swift.Error { case gameNotFound
    }
    
}

/// Originator
 
class Originator {
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func save() -> Memento{
        return user
    }
    
    func restore(user: Memento) {
        
    }
}
