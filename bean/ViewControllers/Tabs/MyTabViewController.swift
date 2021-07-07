//
//  MyTabViewController.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class MyTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(_ sender: Any) {
        AuthManager.shared.signOut()
    }
}
