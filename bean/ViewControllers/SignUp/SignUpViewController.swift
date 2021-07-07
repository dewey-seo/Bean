//
//  SignUpViewController.swift
//  bean
//
//  Created by dewey seo on 27/06/2021.
//

import UIKit
import FirebaseAuth
import RxSwift
import Kingfisher

class SignUpViewController: UIViewController {
    let BOTTOM_BTN_HEIGHT: CGFloat = 50
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var marginB: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailInputContainer: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailBottomLine: UIView!
    
    @IBOutlet weak var nameInputContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameBottomLine: UIView!
    
    @IBOutlet weak var introduceInputContainer: UIView!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var introduceBottomLine: UIView!
    
    var activeTextInput: UIView? {
        didSet {
            self.setScrollOffset()
        }
    }
    
    var user: FirebaseAuth.User?
    let imagePicker = UIImagePickerController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUserInfo()
        setObeservers()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func onPressSignUp(_ sender: Any) {
        
    }
    
    @IBAction func onPressChangeProfile(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.imagePicker.sourceType = .camera
            self.imagePicker.mediaTypes = ["public.image"]
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { action in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.mediaTypes = ["public.image"]
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setLayout() {
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        
        emailLabel.font = .caption2Bold
        nameLabel.font = .caption2Bold
        introduceLabel.font = .caption2Bold
        
        emailTextField.font = .title4
        nameTextField.font = .title4
        introduceTextView.font = .title4
        
        emailLabel.textColor = .grey7
        nameLabel.textColor = .grey7
        introduceLabel.textColor = .grey7
        
        emailBottomLine.backgroundColor = .grey4
        nameBottomLine.backgroundColor = .grey4
        introduceBottomLine.backgroundColor = .grey4
    }
    
    func setUserInfo() {
        guard let user = user else { return }
        
        profileImageView.kf.setImage(with: user.photoURL)
        emailTextField.text = user.email
        nameTextField.text = user.displayName
    }
    
    func onSelectProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
    
    func onChangeKeyboardStatus(_ status: ResultKeyboardStatus) {
        UIView.animate(withDuration: 0.25) {
            switch(status) {
            case .hide:
                self.marginB.constant = 0
                
                self.signUpButtonHeight.constant = self.BOTTOM_BTN_HEIGHT + safeAreaBottom
                self.signUpButton.contentEdgeInsets.bottom = safeAreaBottom
            case .show(let rect):
                let keyboardViewEndFrame = self.view.convert(rect, to: self.view.window)
                let keyboardFrame = self.view.bounds.intersection(keyboardViewEndFrame)
                self.marginB.constant = keyboardFrame.height
                
                console(keyboardFrame.height)
                self.signUpButtonHeight.constant = self.BOTTOM_BTN_HEIGHT
                self.signUpButton.contentEdgeInsets.bottom = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func setScrollOffset() {
        guard let targetView = self.activeTextInput else { return }
        console("target", targetView.tag, targetView.frame.maxY)
        
        let targetY = (targetView.frame.maxY + 70) - scrollView.frame.size.height
        scrollView.setContentOffset(CGPoint(x: 0, y: max(min(scrollView.maxContentOffset.y, targetY), 0)), animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            onSelectProfileImage(image)
        } else {
            showAlert(message: "error - picker")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController {
    func setObeservers() {
        setValidationObserver()
        setSignUpButtonObeserver()
        setTextInputObserver()
    }
    
    func setSignUpButtonObeserver() {
        KeyboardObserve.shared.observingKeyboardHeightChange()
            .subscribe(onNext: { [weak self] status in
                self?.onChangeKeyboardStatus(status)
            })
            .disposed(by: disposeBag)
    }
    
    
    func setTextInputObserver() {
        // Email
        emailTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.emailLabel.textColor = .primary6
                self.emailBottomLine.backgroundColor = .primary6
                self.activeTextInput = self.emailInputContainer
                self.activeTextInput?.tag = 100
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.emailLabel.textColor = .grey7
                self.emailBottomLine.backgroundColor = .grey4
                
            })
            .disposed(by: disposeBag)
        
        // Name
        nameTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.nameLabel.textColor = .primary6
                self.nameBottomLine.backgroundColor = .primary6
                self.activeTextInput = self.nameInputContainer
                self.activeTextInput?.tag = 200
            })
            .disposed(by: disposeBag)
        
        nameTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.nameLabel.textColor = .grey7
                self.nameBottomLine.backgroundColor = .grey4
                self.activeTextInput = nil
            })
            .disposed(by: disposeBag)
        
        // Introduce
        introduceTextView.rx.didBeginEditing.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.introduceLabel.textColor = .primary6
            self.introduceBottomLine.backgroundColor = .primary6
            self.activeTextInput = self.introduceInputContainer
            self.activeTextInput?.tag = 300
        }).disposed(by: disposeBag)
        
        introduceTextView.rx.didEndEditing.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.introduceLabel.textColor = .grey7
            self.introduceBottomLine.backgroundColor = .grey4
            self.activeTextInput = nil
        }).disposed(by: disposeBag)
    }
    
    func setValidationObserver() {
        let source1 = profileImageView.rx.observe(Optional<UIImage>.self, "image").map { $0 != nil }
        let source2 = emailTextField.rx.text.orEmpty.map { $0.isValidEmail() }
        let source3 = nameTextField.rx.text.orEmpty.map { $0.count > 0 }
        let source4 = introduceTextView.rx.text.orEmpty.map { $0.count > 0}
        
        Observable.combineLatest(source1, source2, source3, source4).map { $0 && $1 && $2 && $3 }
            .subscribe { [weak self] isEnabled in
                self?.signUpButton.setIsEnabled(isEnabled, withColor: UIColor.buttonColor(withIsEnabled: isEnabled))
            }
            .disposed(by: disposeBag)
    }
}
