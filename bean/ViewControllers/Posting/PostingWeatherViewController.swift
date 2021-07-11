//
//  PostingWeatherViewController.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit
import RxSwift

protocol PostingWeatherViewControllerDelegate: AnyObject {
    func didFinishedPosting()
    func cancelPosting()
}

class PostingWeatherViewController: UIViewController {
    weak var delegate: PostingWeatherViewControllerDelegate?
   
    let disposeBag: DisposeBag = DisposeBag()
    var weather: Weather?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var postingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primary1
        weatherIcon.addBorderLine(color: .grey2)
        weatherIcon.roundCorenrs(8)
        
        titleLabel.setStyle(font: .body1Bold, color: .black, text: "")
        descriptionLabel.setStyle(font: .caption2, color: .grey6, text: "")
        postingButton.setStyle(bgColor: .primary6, title: "Posting", font: .headline1Bold, titleColor: .white, radius: 8)
        getLocation()
    }
    
    @IBAction func start(_ sender: Any) {
        getLocation()
    }
    
    func getLocation() {
        LocationManager.shared.getCurrentLocation { [weak self] location in
            console("🔴 - location: \(location)")
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            console("🔴 - in: \(lat), \(lon)")
            self?.getWeather(lat, lon)
        }
    }
    
    func getWeather(_ lat: String, _ lon: String) {
        WeatherApiRouter.getCurrentWeather(lat, lon)
            .request(Weather.self)
            .subscribe(onSuccess: { [weak self] response in
                if let weather = response.data {
                    self?.displayWeather(weather)
                }
            }, onFailure: { error in
                
            })
            .disposed(by: disposeBag)
    }
    
    func displayWeather(_ weather: Weather) {
        self.weather = weather
        titleLabel.text = weather.display.first?.title ?? ""
        descriptionLabel.text = weather.display.first?.description ?? ""
        if let icon = weather.localIcon, let image = UIImage(named: icon) {
            weatherIcon.image = image
            return
        }
        let _ = try? weatherIcon.kf.setImage(with: weather.weatherIcon.asURL())
    }
    @IBAction func postPressed(_ sender: Any) {
        guard let weather = weather else {
            return
        }
        
        PostService.shared.postWeather(weather: weather, completion: { [weak self] success in
            if success {
                self?.delegate?.didFinishedPosting()
            } else {
                self?.showAlert(message: "ERROR - POSTING")
            }
        })
    }
}
