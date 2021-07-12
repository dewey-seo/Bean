//
//  PostingPlaceViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit
import MapKit

protocol PostingPlaceViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingPlaceViewController: UIViewController {
    weak var delegate: PostingPlaceViewControllerDelegate?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
