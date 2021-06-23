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
        WeatherApiRouter.getCurrentWeather(lat, lon)
            .request(Weather.self)
            .subscribe { [weak self] response in
                if let weather = response.data {
                    self?.displayWeather(weather)
                }
            } onFailure: { error in
            }
            .disposed(by: disposeBag)
    }
    
    func displayWeather(_ weather: Weather) {
        titleLabel.text = weather.display.first?.title ?? ""
        descriptionLabel.text = weather.display.first?.description ?? ""
        let _ = try? weatherIcon.kf.setImage(with: weather.weatherIcon.asURL())
    }
}
