//
//  MusicSearchViewController.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class MusicSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let disposBag = DisposeBag()
    var searchResult: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    @IBAction func onPressSearch(_ sender: Any) {
        if let keyword = self.searchTextField.text, keyword.count > 0 {
            MusicApiRouter.searchMusic(keyword).request(MusicSearchResult.self)
                .subscribe(
                    onSuccess: { [weak self] response in
                        self?.searchResult = response.data?.results ?? []
                        self?.tableView.reloadData()
                    },
                    onFailure: { [weak self] error in
                        self?.searchResult = []
                    })
                .disposed(by: disposBag)
        }
    }
    
    func bindTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicSearchResultItemCell", bundle: nil), forCellReuseIdentifier: MusicSearchResultItemCell.cellIdentifier)
        
        //        searchResult.bind(to: tableView.rx.items(cellIdentifier:MusicSearchResultItemCell.cellIdentifier,
        //                                                 cellType: MusicSearchResultItemCell.self)) { (_, model: Music, cell: MusicSearchResultItemCell) in
        //            cell.setModel(model)
        //        }
        //        .disposed(by: disposBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicSearchResultItemCell.cellIdentifier) as! MusicSearchResultItemCell
        cell.selectionStyle = .none
        cell.setModel(searchResult[indexPath.row])
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
}
