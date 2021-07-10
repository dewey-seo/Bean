//
//  PostingPhotoViewController.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit
import RxSwift
import YPImagePicker

protocol PostingPhotoViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingPhotoViewController: UIViewController {
    let BOTTOM_BTN_HEIGHT: CGFloat = 50
    let commentMaxCount = 100
    
    weak var delegate: PostingPhotoViewControllerDelegate?
    var presetImage: UIImage?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var postingButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var marginB: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonHeight: NSLayoutConstraint!
    
    let imagePicker = YPImagePicker()
    var isMounted = false
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        setNavigationbar()
        setKeyboardChangeObserver()
        setSubviews()
        bindCheckPostingButtonEnabled()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isMounted {
            onPressSelectImage()
            isMounted = true
        }
    }
    
    func setNavigationbar() {
        self.title = "Photo"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = .grey1
        }
    }
    
    func setSubviews() {
        postImageView.contentMode = .scaleAspectFit
        postImageView.roundCorenrs(12)
        postingButton.setIsEnabled(false, withColor: UIColor.buttonColor(withIsEnabled: false))
        postingButton.setTitle("Post", for: .normal)
        postingButton.setTitleColor(.white, for: .normal)
        postingButton.titleLabel?.font = .caption1Bold
        
        commentTextView.delegate = self
        placeholder.text = "Write a caption..."
        placeholder.textColor = .grey5
        placeholder.font = .body1
        
        textCountLabel.text = "\(0)/\(commentMaxCount)"
        textCountLabel.textColor = .grey6
        textCountLabel.font = .body1
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
    
    @IBAction func onPressSelectImage() {
        imagePicker.didFinishPicking { [weak self, unowned imagePicker] items, _ in
            if let photo = items.singlePhoto {
                self?.postImageView.image = photo.image
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onPressPosting(_ sender: Any) {
        guard let image = postImageView.image, let comment = commentTextView.text else {
            return
        }
        
        PostService.shared.postPhoto(image: image, comment: comment) { [weak self] result in
            if result {
                self?.delegate?.didFinishedPosting()
            } else {
                self?.showAlert(message: "ERROR - POST UPLOAD")
            }
        }
    }
}


extension PostingPhotoViewController {
    func setKeyboardChangeObserver() {
        KeyboardObserve.shared.observingKeyboardHeightChange()
            .subscribe(onNext: { [weak self] status in
                self?.onChangeKeyboardStatus(status)
            })
            .disposed(by: disposeBag)
    }
    
    func onChangeKeyboardStatus(_ status: ResultKeyboardStatus) {
        UIView.animate(withDuration: 0.25) {
            switch(status) {
            case .hide:
                self.marginB.constant = 0
                
                self.bottomButtonHeight.constant = self.BOTTOM_BTN_HEIGHT + safeAreaBottom
                self.postingButton.contentEdgeInsets.bottom = safeAreaBottom
            case .show(let rect):
                let keyboardViewEndFrame = self.view.convert(rect, to: self.view.window)
                let keyboardFrame = self.view.bounds.intersection(keyboardViewEndFrame)
                self.marginB.constant = keyboardViewEndFrame.height
                
                console(keyboardFrame.height)
                self.bottomButtonHeight.constant = self.BOTTOM_BTN_HEIGHT
                self.postingButton.contentEdgeInsets.bottom = 0
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension PostingPhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholder.isHidden = true
        self.scrollView.scrollToMaxContentOffset(animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder.isHidden = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        textCountLabel.text = "\(count)/\(commentMaxCount)"
    }
}
