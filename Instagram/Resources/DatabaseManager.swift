//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Admin on 24.01.2022.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    //private let database = Database.database().reference()
    let database = Database.database(url:"https://instagram-f704e-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    // MARK: - Public
    
    ///Check if we username and email are available
    /// - Parameters
    ///         - email: String representing email
    ///         - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool)->Void) {
        completion(true)
    }
    
    ///Insert new user to database
    /// - Parameters
    ///         - email: String representing email
    ///         - username: String representing username
    ///         - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool)->Void) {
        let key = email.safeKey()
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                print("err")
                return
            }
        }
    }
    
}
