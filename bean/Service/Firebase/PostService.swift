//
//  PostService.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import FirebaseAuth
import FirebaseFirestore

enum PostServiceError: Error {
    case test
}

class PostService: FirebaseService {
    static let shared = PostService()
    
    let COLLECTION_PATH_D1 = "Feed"
    let COLLECTION_PATH_D2 = "Posts"
    
    func uploadPost(_ post: PostModel, completion: @escaping (_ result: Bool) -> Void) {
        guard let userId = AuthManager.shared.userId else {
            return completion(false)
        }
        
        let document = self.store.collection(COLLECTION_PATH_D1).document(userId).collection(COLLECTION_PATH_D2).document()
        let id = document.documentID
        
        guard let data = post.asDictionary(["id": id]) else {
            return completion(false)
        }
        
        document.setData(data) { error in
            completion(error != nil)
        }
    }
    
    func postPhoto(image: UIImage, comment: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Upload Image
        StorageService.uploadImage(type: .postImage, image: image) { [weak self] result in
            switch(result) {
            case .success(let url):
                let gsImage = image.convertGrayScale(image: image)
                let gsImageData = gsImage?.jpegData(compressionQuality: 0.1)
                
                // Create Post
                let post = PhotoPost(type: .photo, photoUrl: url, comment: comment, previewImageData: gsImageData)
                
                // Posting
                self?.uploadPost(post, completion: { result in
                    console("posting \(result ? "success" : "failed")")
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
