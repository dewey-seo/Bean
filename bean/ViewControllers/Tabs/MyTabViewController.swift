//
//  MyTabViewController.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import RxSwift

class MyTabViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var marginB: NSLayoutConstraint!
    @IBOutlet weak var logoutButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubViews()
        bindUser()
    }
    
    func setSubViews() {
        profileImageView.roundCorenrs(8)
        
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
        
        emailTextField.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        introduceTextView.isUserInteractionEnabled = false
        
        logoutButton.setStyle(bgColor: .primary6, title: "Logout", font: .headline1Bold, titleColor: .white, radius: 8)
    }
    
    func bindUser() {
        RealmManager.shared.ovservingUser()
            .subscribe (onNext: { [weak self] user in
                if let user = user{
                    self?.setUser(user)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setUser(_ user: User) {
        if let url = try? user.profileUrl.asURL() {
            profileImageView.kf.setImage(with: url)
        }

        emailTextField.text = user.email
        nameTextField.text = user.name
        introduceTextView.text = user.introduce
    }
    
    @IBAction func logout(_ sender: Any) {
        AuthManager.shared.signOut()
    }
}
