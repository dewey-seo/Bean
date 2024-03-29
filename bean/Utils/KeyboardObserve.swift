//
//  KeyboardObserve.swift
//  bean
//
//  Created by dewey seo on 30/06/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum ResultKeyboardStatus {
    case show(rect: CGRect)
    case hide
}

class KeyboardObserve {
    static let shared = KeyboardObserve()
    private var keyboardChange = BehaviorSubject<ResultKeyboardStatus>(value: .hide)
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboarFrameChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (notification.name ==  UIResponder.keyboardWillShowNotification) {
                console("show", keyboardScreenEndFrame)
                self.keyboardChange.onNext(.show(rect: keyboardScreenEndFrame))
            } else {
                console("hide", keyboardScreenEndFrame)
                self.keyboardChange.onNext(.hide)
            }
        }
    }
    
    func observingKeyboardHeightChange() -> Observable<ResultKeyboardStatus> {
        return keyboardChange.asObserver()
    }
}
