//
//  Schedule.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-01-28.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

class Schedule: Identifiable, Codable {
    @DocumentID var docId : String?
    var id = UUID()
    var scheduleTitel = "Vecka"
    var monday = Day()
    var tuesday = Day()
    var wednesday = Day()
    var thursday = Day()
    var friday = Day()
    var saturday = Day()
    var sunday = Day()
    
}
