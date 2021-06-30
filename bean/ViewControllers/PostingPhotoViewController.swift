//
//  PostingPhotoViewController.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit

class PostingPhotoViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    @IBAction func onPressSelectImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func onPressPosting(_ sender: Any) {
    }
}

extension PostingPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
