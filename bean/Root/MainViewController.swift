//
//  MainViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPressLogout(_ sender: Any) {
        AuthManager.shared.signOut()
    }
    @IBAction func onPressSpotify(_ sender: Any) {
        let musicVC = MusicSearchViewController.init(nibName: "MusicSearchViewController", bundle: nil)
        navigationController?.pushViewController(musicVC, animated: true)
    }
    
    @IBAction func onPressWeather(_ sender: Any) {
        let weatherVC = WeatherViewController.init(nibName: "WeatherViewController", bundle: nil)
        navigationController?.pushViewController(weatherVC, animated: true)
    }
    @IBAction func onPressPhoto(_ sender: Any) {
        let postingPhotoVC = PostingPhotoViewController.init(nibName: "PostingPhotoViewController", bundle: nil)
        navigationController?.pushViewController(postingPhotoVC, animated: true)
    }
}
