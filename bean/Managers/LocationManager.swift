//
//  LocationManager.swift
//  bean
//
//  Created by dewey seo on 20/06/2021.
//

import Foundation
import CoreLocation

typealias LocationCompletion = ((CLLocation) -> Void)
class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion: LocationCompletion?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        manager.requestAlwaysAuthorization()
    }
    
    func getCurrentLocation(completion: @escaping LocationCompletion) {
        self.completion = completion
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        completion = nil
        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print("🔴: \(manager.authorizationStatus.rawValue)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("🔴: \(error.localizedDescription)")
    }
}
