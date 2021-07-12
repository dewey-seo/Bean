//
//  Location.swift
//  bean
//
//  Created by dewey seo on 12/07/2021.
//

import MapKit

func formattedAddressForPlacemark(placemark: CLPlacemark, includeName: Bool = true, withLineBreaks: Bool = true, showCountryIfUSA: Bool = false) -> String {
    var addressArray = [String]()
    
    if let subThoroughfare = placemark.subThoroughfare {
        addressArray.append(subThoroughfare + " ")
    }
    if let thoroughfare = placemark.thoroughfare {
        addressArray.append(thoroughfare + ", ")
    }
    if let postalCode = placemark.postalCode {
        addressArray.append(postalCode + " ")
    }
    if let locality = placemark.locality {
        addressArray.append(locality + ", ")
    }
    if let administrativeArea = placemark.administrativeArea  {
        addressArray.append(administrativeArea + " ")
    }
    if let country = placemark.country {
        addressArray.append(country)
    }
    
    return addressArray.joined()
}

