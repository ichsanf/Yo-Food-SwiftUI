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
    
    // Location Details Variables...
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Checking Location Access...
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            manager.requestLocation()
            self.noLocation = false
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            LocationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Reading User Location and Extracting Details...
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            guard let safeData = res
            else {
                return
            }
            
            var address = ""
            
            // Getting Area and Local names
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
}
