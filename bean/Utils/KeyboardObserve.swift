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

class KeyboardObserve {
    let shared = KeyboardObserve()
    
    func keyboardHeightChange() -> Observable<CGFloat> {
        return Observable.from([
            NotificationCenter.default.rx
                .notification(UIResponder.keyboardWillShowNotification)
                .map { notification -> CGFloat in
                    guard let userInfo = notification.userInfo, let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                        return 0
                    }
                    return value.cgRectValue.height
                },
            NotificationCenter.default.rx
                .notification(UIResponder.keyboardWillHideNotification)
                .map { notification -> CGFloat in
                    guard let userInfo = notification.userInfo, let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                        return 0
                    }
                    return value.cgRectValue.height
                },
            NotificationCenter.default.rx
                .notification(UIResponder.keyboardWillChangeFrameNotification)
                .map { notification -> CGFloat in
                    guard let userInfo = notification.userInfo, let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                        return 0
                    }
                    return value.cgRectValue.height
                },
        ])
        .merge()
    }
}
