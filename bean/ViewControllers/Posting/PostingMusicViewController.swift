//
//  PostingMusicViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit
import SnapKit
import RxSwift

protocol PostingMusicViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingMusicViewController: UIViewController {
    weak var delegate: PostingMusicViewControllerDelegate?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var marginB: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    var searchResult: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        setNavigationbar()
        setSubviews()
        setKeyboardChangeObserver()
        bindTextField()
    }
    
    func setNavigationbar() {
        self.title = "What were you listen..."
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
        searchTextField.roundCorenrs(12)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicSearchResultItemCell", bundle: nil), forCellReuseIdentifier: MusicSearchResultItemCell.cellIdentifier)
        tableView.separatorColor = .grey2
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 16, right: 16)
    }
    
    func bindTextField() {
        searchTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe { [weak self] _ in
            self?.searchButtonPressed()
        }.disposed(by: disposeBag)
        // TODO: - rxswift Text change && debounce
    }
    
    @IBAction func searchButtonPressed() {
        if let keyword = self.searchTextField.text, keyword.count > 0 {
            self.searchMusic(keyword)
        }
    }
    
    func searchMusic(_ keyword: String) {
        MusicApiRouter.searchMusic(keyword).request(MusicSearchResult.self)
            .subscribe(
                onSuccess: { [weak self] response in
                    self?.searchResult = response.data?.results ?? []
                    self?.tableView.reloadData()
                    self?.view.endEditing(true)
                },
                onFailure: { [weak self] error in
                    self?.searchResult = []
                })
            .disposed(by: disposeBag)
    }
}

extension PostingMusicViewController: UITableViewDelegate, UITableViewDataSource {
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
        let popupView = MusicPopupView()
        popupView.model = searchResult[indexPath.row]
        popupView.delegate = self
        PopupViewController.shared.showPopupView(popupView: popupView, animate: true)
    }
}

extension PostingMusicViewController: MusicPopupViewDelegate {
    func musicPopupViewPostButtonPressed(popupView: MusicPopupView, model: Music) {
        PostService.shared.postMusic(music: model, completion: { [weak self] success in
            if success {
                PopupViewController.shared.hidePopupView(animate: true) {
                    self?.delegate?.didFinishedPosting()
                }
            } else {
                self?.showAlert(message: "error - posting music")
            }
        })
    }
}

extension PostingMusicViewController {
    func setKeyboardChangeObserver() {
        KeyboardObserve.shared.observingKeyboardHeightChange()
            .subscribe(onNext: { [weak self] status in
                self?.onChangeKeyboardStatus(status)
            })
            .disposed(by: disposeBag)
    }
    
    func onChangeKeyboardStatus(_ status: ResultKeyboardStatus) {
        UIView.animate(withDuration: 0.25) {
            switch(status) {
            case .hide:
                self.marginB.constant = 0
            case .show(let rect):
                let keyboardViewEndFrame = self.view.convert(rect, to: self.view.window)
                let keyboardFrame = self.view.bounds.intersection(keyboardViewEndFrame)
                self.marginB.constant = keyboardFrame.height
            }
            self.view.layoutIfNeeded()
        }
    }
}
