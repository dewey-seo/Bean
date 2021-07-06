//
//  SignUpViewController.swift
//  bean
//
//  Created by dewey seo on 27/06/2021.
//

import UIKit
import FirebaseAuth
import RxSwift

class SignUpViewController: UIViewController {
    let bottomButtonDefaultHeight: CGFloat = 50
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var buttomButton: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserInfo()
        bindBottomButton()
    }
    
    func setUserInfo() {
        
    }
    
    func bindBottomButton() {
        KeyboardObserve.shared.keyboardHeightChange()
            .subscribe(onNext: { [weak self] height in
                guard let self = self else { return }
                self.changeKeyboardHeight(height: height)
            })
            .disposed(by: disposeBag)
    }
    
    func changeKeyboardHeight(height: CGFloat) {
        if(height > 0) {
            self.bottomMargin.constant = height
            self.buttonHeight.constant = self.bottomButtonDefaultHeight
            self.buttomButton.contentEdgeInsets.bottom = 0
        } else {
            self.bottomMargin.constant = 0
            self.buttonHeight.constant = self.bottomButtonDefaultHeight + safeAreaBottom
            self.buttomButton.contentEdgeInsets.bottom = safeAreaBottom
        }
    }
}
