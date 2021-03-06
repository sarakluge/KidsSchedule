//
//  KidsScheduleApp.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-01-28.
//

import SwiftUI
import Firebase

@main
struct KidsScheduleApp: App {
    
    init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
