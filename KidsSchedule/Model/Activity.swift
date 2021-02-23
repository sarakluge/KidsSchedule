//
//  File.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-01-28.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Activity: Identifiable, Codable{
    var id = UUID()
    var title: String
    var time: String
    var location: String
    //var imageName: String
    //var image: Image {Image(imageName)}
}
