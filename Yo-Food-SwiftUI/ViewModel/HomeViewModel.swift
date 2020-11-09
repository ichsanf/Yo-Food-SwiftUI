//
//  HomeViewModel.swift
//  Yo-Food-SwiftUI
//
//  Created by Achmad Ichsan Fauzi on 06/11/20.
//

import SwiftUI
import CoreLocation
import Firebase

// Fetching user location...
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var LocationManager = CLLocationManager()
    @Published var search = ""
    
    // Location Details Variables...
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    // Menu...
    @Published var showMenu = false
    
    // ItemData...
    @Published var items: [Item] = []
    
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
        self.login()
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
    
    // Anonymous login for reading database...
    func login() {
        Auth.auth().signInAnonymously { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            } else {
                print("Success =  \(res!.user.uid)")
                
                // After logging in...
                self.fetchData()
            }
        }
    }
    
    // Fetching Items Data...
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { (snap, err) in
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
        }
    }
}
