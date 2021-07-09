//
//  HomeTabViewController.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

protocol HomeTabViewControllerDelegate: AnyObject {
    func onPressWirte(type: ChooserType)
}

class HomeTabViewController: UIViewController {
    
    weak var delegate: HomeTabViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
}

// MARK: - Navigation
extension HomeTabViewController {
    func setNavigation() {
        let writeButton = UIBarButtonItem("nav_write", target: self, action: #selector(onPressWrite), for: .touchUpInside)
        self.navigationItem.setRightBarButton(writeButton, animated: true)
        self.navigationItem.title = "Home"
    }
    
    @objc func onPressWrite() {
        let chooserVC = PostingChooserViewController.init(nibName: "PostingChooserViewController", bundle: nil)
        chooserVC.delegate = self
        self.present(chooserVC, animated: true, completion: nil)
    }
}

// MARK: - PostingChooserDelegate
extension HomeTabViewController: PostingChooserDelegate {
    func didSelectChooser(type: ChooserType) {
        self.delegate?.onPressWirte(type: type)
    }
}
