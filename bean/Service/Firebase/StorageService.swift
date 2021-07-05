//
//  StorageService.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import Foundation
import Firebase
import FirebaseStorage

enum StorageServiceError: Error {
    case unknownError
    case invalidUserId
    case uploadingError
}

enum StorageType {
    case postImage
    case profileImage
    case profileThumbnail
    
    func uploadImagePath(userId: String) -> String {
        switch (self) {
        case .postImage:
            return "Post/Photo/" + [userId, Time.currentDateString].joined(separator: "_") + ".jpeg"
        case .profileImage:
            return "User/Profile/"
        case .profileThumbnail:
            return "User/Profile/Thumbnail/"
        }
    }
}

class StorageService {
    static let shared = StorageService()
    let storage = Storage.storage()
    
    static func uploadImage(type: StorageType, path: String, completion: (_ url: String) -> Void) {
        //        StorageService.shared.
        //        let localFile = URL(string: path)
    }
    
    static func uploadImage(type: StorageType, image: UIImage, completion: @escaping (Result<URL, StorageServiceError>) -> Void) {
        let ref = StorageService.shared.storage.reference()
        let refForGs = StorageService.shared.storage.reference()
        guard let userId = AuthManager.shared.userId, let data = image.jpegData(compressionQuality: 0.8) else {
            return completion(.failure(.invalidUserId))
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Set upload
        let uploadTask = ref.child(type.uploadImagePath(userId: userId)).putData(data, metadata: metadata)
        refForGs.child(type.uploadImagePath(userId: userId))
        
        // observing // TODO:- rx return
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            console("upload - \(percentComplete)%")
        }
        
        uploadTask.observe(.success) { snapshot in
            snapshot.reference.downloadURL { downloadUrl, error in
                guard let downloadUrl = downloadUrl else {
                    return completion(.failure(.uploadingError))
                }
                completion(.success(downloadUrl))
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.uploadingError))
        }
    }
}
