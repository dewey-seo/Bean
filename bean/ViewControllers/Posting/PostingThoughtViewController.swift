//
//  PostingThoughtViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

protocol PostingThoughtViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}


class PostingThoughtViewController: UIViewController {
    weak var delegate: PostingThoughtViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
