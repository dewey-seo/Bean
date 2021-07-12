//
//  PostingPlaceViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit
import MapKit
import RxSwift

protocol PostingPlaceViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingPlaceViewController: UIViewController {
    weak var delegate: PostingPlaceViewControllerDelegate?
    
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var marginB: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    var searchResult: [MKMapItem] = []{
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let completer = MKLocalSearchCompleter()
    let annotation: MKPointAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationbar()
        setSubviews()
        getCurrentLocation()
    }
    
    func setNavigationbar() {
        self.title = "Place"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = .grey1
            navigationBar.shadowImage = UIImage()
        }
    }
    
    func setSubviews() {
        let leftSubview = UIImageView(name: "icon_search_placeholder")
        let leftView = UIView()
        leftView.addSubview(leftSubview)
        leftView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        leftSubview.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        searchBar.backgroundColor = .grey1
        searchTextField.backgroundColor = .grey2
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        searchTextField.placeholder = "input english..."
        searchTextField.roundCorenrs(12)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "PlaceSearchResultItemCell", bundle: nil), forCellReuseIdentifier: PlaceSearchResultItemCell.reuseIdentifier)
        tableView.separatorColor = .grey2
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 16, right: 16)
        
        mapView.addAnnotation(annotation)
        completer.delegate = self
        completer.queryFragment = ""
    }
    
    func bindTextField() {
        searchTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe { [weak self] _ in
            self?.searchButtonPressed()
        }.disposed(by: disposeBag)
    }
    
    @IBAction func searchButtonPressed() {
        // MKLocalsearch apply
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTextField.text
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else {
                self?.showAlert(message: "ERROR - search location")
                return
            }
            self?.searchResult = response.mapItems
        }
    }
    
    func getCurrentLocation() {
        LocationManager.shared.getCurrentLocation { [weak self] location in
            console("🔴 - location: \(location)")
            self?.moveToLocationWithPin(location: location)
        }
    }
    func moveToLocationWithPin(location: CLLocation) {
        annotation.coordinate = location.coordinate
        mapView.centerToLocation(location)
    }
}

extension PostingPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchResult[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: PlaceSearchResultItemCell.reuseIdentifier) as? PlaceSearchResultItemCell {
            cell.item = item
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "unknown")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResult[indexPath.row]
        if let location = item.placemark.location {
            moveToLocationWithPin(location: location)
        }
    }
}

extension PostingPlaceViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        print("")
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("")
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
