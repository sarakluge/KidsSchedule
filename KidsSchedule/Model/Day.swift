//
//  Day.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-01-28.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

class Day: Identifiable, Codable {
    //@DocumentId var id = String?
    var id = UUID()
    var activities =  [Activity]()

    
    
    init() {
        addMockData()
    }
    
    func addMockData() {
        activities.append(Activity(title: "Skola", time: "8:00-13:30", location: "Kumla Skola"))
        activities.append(Activity(title: "Hockey", time: "16.00-17:30", location: "Fontanahallen"))
        activities.append(Activity(title: "Läsläxa", time: "18.00-18:30", location: "Hemma"))
            
    }

}
