//
//  PostingPlaceViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

protocol PostingPlaceViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingPlaceViewController: UIViewController {
    weak var delegate: PostingPlaceViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
