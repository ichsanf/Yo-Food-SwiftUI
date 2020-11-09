//
//  Yo_Food_SwiftUIApp.swift
//  Yo-Food-SwiftUI
//
//  Created by Achmad Ichsan Fauzi on 31/10/20.
//

import SwiftUI
import Firebase

@main
struct Yo_Food_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// init Firebase...
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
