//
//  SignUpViewController.swift
//  bean
//
//  Created by dewey seo on 27/06/2021.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var user: User?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else {
            let alert = UIAlertController(title: "ERROR", message: "user info error", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { [weak self] action in
                self?.onPressClose()
            }))
            
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        
        if let profileUrl = try? user.profileUrl?.asURL() {
            profileImageView.kf.setImage(with: profileUrl)
        }
        nameLabel.text = user.name ?? "unknown"
        emailLabel.text = user.email ?? "unknown"
        phoneLabel.text = user.phone ?? "unknown"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let close = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(onPressClose))
        self.navigationItem.setLeftBarButton(close, animated: false)
    }
    
    @IBAction func onPressClose() {
        self.navigationController?.dismiss(animated: true, completion: {
            AuthManager.shared.signOut()
        })
    }
    
    @IBAction func onPressRegister(_ sender: Any) {
        guard let user = user else {
            return
        }
        UserService.shared.registerUser(user: user) { result in
            print(result)
        }
    }
}
