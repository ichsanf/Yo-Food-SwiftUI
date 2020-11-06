//
//  HomeViewModel.swift
//  Yo-Food-SwiftUI
//
//  Created by Achmad Ichsan Fauzi on 06/11/20.
//

import SwiftUI
import CoreLocation

// Fetching user location...
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var LocationManager = CLLocationManager()
    @Published var search = ""
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Checking Location Access...
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
        case .denied:
            print("denied")
        default:
            print("unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
}
