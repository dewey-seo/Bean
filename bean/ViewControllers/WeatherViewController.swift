//
//  WeatherViewController.swift
//  bean
//
//  Created by dewey seo on 20/06/2021.
//

import UIKit
import RxSwift
import Kingfisher

class WeatherViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherIcon.layer.borderWidth = 1
        weatherIcon.layer.borderColor = UIColor.black.cgColor
        weatherIcon.layer.cornerRadius = 50
    }
    
    @IBAction func start(_ sender: Any) {
        getLocation()
    }
    
    func getLocation() {
        LocationManager.shared.getCurrentLocation { [weak self] location in
            print("🔴 - location: \(location)")
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            print("🔴 - in: \(lat), \(lon)")
            self?.getWeather(lat, lon)
        }
    }
    
    func getWeather(_ lat: String, _ lon: String) {
        ApiService
            .request(WeatherApiRouter.getCurrentWeather(lat, lon))
            .subscribe { [weak self] response in
                if let res = response as? NSDictionary {
                    if let weatherArray = res.object(forKey: "weather") as? Array<NSDictionary> {
                        if let weather = weatherArray.first {
                            if let title = weather.object(forKey: "main") as? String,
                               let description = weather.object(forKey: "description") as? String,
                               let icon = weather.object(forKey: "icon") as? String
                            {
                                self?.displayWeather(title, description, icon)
                            }
                        }
                    }
                }
            } onFailure: { err in
                
            }
            .disposed(by: disposeBag)
    }
    
    func displayWeather(_ title: String, _ description:String , _ icon: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        let url = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        try? weatherIcon.kf.setImage(with: url.asURL())
    }
}
