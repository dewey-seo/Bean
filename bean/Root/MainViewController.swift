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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressLogout(_ sender: Any) {
        AuthManager.shared.signOut()
    }
    @IBAction func onPressSpotify(_ sender: Any) {
        
        
    }
    @IBAction func onPressWeather(_ sender: Any) {
        let weatherVC = WeatherViewController.init(nibName: "WeatherViewController", bundle: nil)
        navigationController?.pushViewController(weatherVC, animated: true)
    }
}
