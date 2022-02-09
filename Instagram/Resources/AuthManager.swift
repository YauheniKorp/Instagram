//
//  AuthManager.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import FirebaseDatabase
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerUser(username: String, email: String, password: String, completion: @escaping (Bool)->Void) {
        /*
         - check if username is availalable
         - check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil, error == nil else {
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager().insertNewUser(with: email, username: username) { success in
                        if success {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, competion: @escaping ((Bool) -> Void)) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    competion(false)
                    return
                }
                
                competion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
    /// Attempt to log out firebase user
    public func logOutUser(_ completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch  {
            print(error)
            completion(false)
            return
        }
        
    }
}
