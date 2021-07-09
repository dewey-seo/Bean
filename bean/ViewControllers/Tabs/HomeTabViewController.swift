//
//  HomeTabViewController.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

protocol HomeTabViewControllerDelegate: AnyObject {
    func onPressWirte(type: PostType)
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
        let testVC = PostingChooserViewController.init(nibName: "PostingChooserViewController", bundle: nil)
        self.present(testVC, animated: true, completion: nil)
        
        return
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // Weather
        actionSheet.addAction(UIAlertAction(title: "Weather", style: .default, handler: { _ in
            self.delegate?.onPressWirte(type: .weather)
        }))
        // Music
        actionSheet.addAction(UIAlertAction(title: "Music", style: .default, handler: { _ in
            self.delegate?.onPressWirte(type: .music)
        }))
        // Thougth
        actionSheet.addAction(UIAlertAction(title: "Thougth", style: .default, handler: { _ in
            self.delegate?.onPressWirte(type: .thought)
        }))
        // Photo
        actionSheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { _ in
            self.delegate?.onPressWirte(type: .photo)
        }))
        // Book
//        actionSheet.addAction(UIAlertAction(title: "Book", style: .default, handler: { _ in
//            self.delegate?.onPressWirte(type: .book)
//        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}
