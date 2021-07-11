//
//  HomeTabViewController.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import RxSwift

protocol HomeTabViewControllerDelegate: AnyObject {
    func onPressWirte(type: ChooserType)
}

class HomeTabViewController: UIViewController {
    
    weak var delegate: HomeTabViewControllerDelegate?
    var dataSource: [Post] = []
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MusicPostTableViewCell", bundle: nil), forCellReuseIdentifier: MusicPostTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "PhotoPostTableViewCell", bundle: nil), forCellReuseIdentifier: PhotoPostTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "WeatherPostTableViewCell", bundle: nil), forCellReuseIdentifier: WeatherPostTableViewCell.reuseIdentifier)
        
        DataManager.shared.obaservableFeed
            .subscribe(onNext: { [weak self] posts in
                self?.dataSource = posts
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
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

// MARK: - Tableview
extension HomeTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = dataSource[indexPath.row]
        switch post.postType {
        case .photo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoPostTableViewCell.reuseIdentifier) as? PhotoPostTableViewCell {
                cell.post = post
                return cell
            }
        case .music:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MusicPostTableViewCell.reuseIdentifier) as? MusicPostTableViewCell {
                cell.post = post
                return cell
            }
        case .weather:
            if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherPostTableViewCell.reuseIdentifier) as? WeatherPostTableViewCell {
                cell.post = post
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "unknown") {
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "unknown")
    }
}
