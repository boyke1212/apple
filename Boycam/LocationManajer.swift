//
//  LocationManajer.swift
//  Boycam
//
//  Created by USER on 19/06/22.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationManajer: NSObject, ObservableObject, CLLocationManagerDelegate {
   
    private let locationManager = CLLocationManager()
    let boyprefs = UserDefaults.standard

    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var isi: String=""
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }


        var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
       
    }
    
   
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
        
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude

            let geocoder=CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [self] (placemarks,error) in
                let place = placemarks! as [CLPlacemark]
                                if place.count > 0 {
                                    let place = placemarks![0]
                                    var adressString : String = ""
                                    if place.thoroughfare != nil {
                                        adressString = adressString + place.thoroughfare! + " - "
                                        isi = isi +  place.thoroughfare! + " - "
                                    }
                                    if place.subThoroughfare != nil {
                                        adressString = adressString + place.subThoroughfare! + ", "
                                        isi = isi  + place.subThoroughfare! + ", "
                                    }
                                    if place.locality != nil {
                                        adressString = adressString + place.locality! + " - "
                                        isi = isi + place.locality! + " - "
                                    }
                                    if place.postalCode != nil {
                                        adressString = adressString + place.postalCode! + ", "
                                        isi = isi + place.postalCode! + ", "
                                    }
                                    if place.subAdministrativeArea != nil {
                                        adressString = adressString + place.subAdministrativeArea! + " - "
                                        isi = isi +  place.subAdministrativeArea! + " - "
                                    }
                                    if place.country != nil {
                                        adressString = adressString + place.country!
                                        isi = isi + place.country!
                                    }
                                 

                }
            }
            
        }
    }
  
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
//        tvAlamat.text="Permintaan Location Error/Ditolak Anda tidak dapat melanjutkan Silahkan reinstall Aplikasi jiga ingin meneruskan, atau izin kan location untuk app linmasbjm di setting"
    }
}
