//
//  PostingPhotoViewController.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit
import RxSwift

protocol PostingPhotoViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingPhotoViewController: UIViewController {
    weak var delegate: PostingPhotoViewControllerDelegate?
    var presetImage: UIImage?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var postingButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController.init()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.contentMode = .scaleAspectFit
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        postingButton.setIsEnabled(false, withColor: UIColor.buttonColor(withIsEnabled: false))
        
        bindCheckPostingButtonEnabled()
    }
    
    func bindCheckPostingButtonEnabled() {
        let source1 = postImageView.rx.observe(Optional<UIImage>.self, "image")
        let source2 = commentTextView.rx.text.asObservable() // text vs asObservable?
        Observable.combineLatest(
            source1,
            source2
        ) { s1, s2 in
            return s1 != nil && s2?.count ?? 0 > 0
        }
        .subscribe { isEnabled in
            self.postingButton.setIsEnabled(isEnabled, withColor: UIColor.buttonColor(withIsEnabled: isEnabled))
        }
        .disposed(by: disposeBag)
    }
    
    func pickerControllerDidSelectImage(_ image: UIImage) {
        postImageView.image = image
    }
    
    @IBAction func onPressSelectImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onPressPosting(_ sender: Any) {
        guard let image = postImageView.image, let comment = commentTextView.text else {
            return
        }
        
        PostService.shared.postPhoto(image: image, comment: comment) { result in
            
        }
    }
}

extension PostingPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            pickerControllerDidSelectImage(image)
        } else {
            self.showAlert(message: "error - picker")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
