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
    
    func reloadFeed(_ completion: @escaping (_ result: Bool) -> Void) {
        guard let userId = AuthManager.shared.userId else {
            return completion(false)
        }
        self.store.collection(COLLECTION_PATH_D1).document(userId).collection(COLLECTION_PATH_D2).getDocuments { snap, error in
            guard let documents = snap?.documents else {
                completion(false)
                return
            }
            
            do {
                let posts = try documents.map { queryDocSnapshot -> Post in
                    let data = queryDocSnapshot.data()
                    let json = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(Post.self, from: json)
                    return post
                }
                .sorted(by: { p1, p2 in
                    return p1.createdAt > p2.createdAt
                })
                DataManager.shared.feed = posts
                completion(true)
            } catch {
                completion(false)
            }
            
            completion(true)
        }
    }
    
    func uploadPost(_ post: Post, completion: @escaping (_ result: Bool) -> Void) {
        guard let userId = AuthManager.shared.userId else {
            return completion(false)
        }
        
        let document = self.store.collection(COLLECTION_PATH_D1).document(userId).collection(COLLECTION_PATH_D2).document()
        let id = document.documentID
        
        guard let data = post.asDictionary(["id": id]) else {
            return completion(false)
        }
        
        document.setData(data) { error in
            completion(error == nil)
        }
    }
    
    func postPhoto(image: UIImage, comment: String, completion: @escaping (_ result: Bool) -> Void) {
        // Upload Image
        StorageService.uploadImage(type: .postImage, image: image) { [weak self] result in
            switch(result) {
            case .success(let url):
                let gsImage = image.convertGrayScale(image: image)
                let gsImageData = gsImage?.jpegData(compressionQuality: 0.1)
                
                // Create Post
                let photo = Photo(photoUrl: url, comment: comment, previewImageData: gsImageData)
                let post = Post(type: .photo, data: photo)
                
                // Posting
                self?.uploadPost(post, completion: { result in
                    completion(result)
                })
            case .failure(let _):
                completion(false)
            }
        }
    }
    
    func postMusic(music: Music, completion: @escaping (_ result: Bool) -> Void) {
        let post = Post(type: .music, data: music)
        
        self.uploadPost(post, completion: { result in
            completion(result)
        })
    }
}
