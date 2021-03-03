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
    var id = UUID()
    var activities =  [Activity]()
}
