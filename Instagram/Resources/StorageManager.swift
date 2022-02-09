//
//  StorageManager.swift
//  Instagram
//
//  Created by Admin on 24.01.2022.
//

import FirebaseStorage
import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage(url: "gs://instagram-f704e.appspot.com/").reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadPhoto(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))

        }
    }
    
}

