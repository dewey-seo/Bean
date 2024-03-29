//
//  BeanViewController.swift
//  bean
//
//  Created by dewey seo on 01/07/2021.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, title: String = "", handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in
            handler?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
