//
//  PostingWeatherViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

protocol PostingWeatherViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingWeatherViewController: UIViewController {
    weak var delegate: PostingWeatherViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
