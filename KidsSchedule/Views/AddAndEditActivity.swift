//
//  AddAndEditActivity.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-02-23.
//

import Foundation
import SwiftUI
import Firebase

struct AddActivitySheet: View {
    
    var listOfDays = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
    @State var selectedDay = "Måndag"
    @State var title = ""
    @State var time = ""
    @State var location = ""
    var db = Firestore.firestore()
    @Environment(\.presentationMode) var presentationMode
    @State var currentSchedule: Schedule
    
    var body: some View {
        NavigationView{
            Form{
                Picker(selection: $selectedDay, label: Text("Dag")){
                    ForEach(listOfDays, id: \.self) { day in
                        Text(day)
                    }
                }
                HStack{
                    Text("Titel: ")
                    TextField("Titel", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Image(systemName: "clock")
                    Text("Tid: ")
                    TextField("Tid", text: $time)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text("Plats: ")
                    TextField("Plats", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Button("Spara") {
                        addActivityToFirestore(selectedDay: selectedDay, title: title, time: time, location: location)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Button("Stäng") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    func addActivityToFirestore(selectedDay: String, title: String, time: String, location: String) {
        let activity = Activity(title: title, time: time, location: location)
        let schedule = currentSchedule
        
        switch selectedDay {
        case "Måndag":
            schedule.monday.activities.append(activity)
        case "Tisdag":
            schedule.tuesday.activities.append(activity)
        case "Onsdag":
            schedule.wednesday.activities.append(activity)
        case "Torsdag":
            schedule.thursday.activities.append(activity)
        case "Fredag":
            schedule.friday.activities.append(activity)
        case "Lördag":
            schedule.saturday.activities.append(activity)
        case "Söndag":
            schedule.sunday.activities.append(activity)
        default :
            print("defualt")
        }
        
        do {
            if currentSchedule.docId == nil {
                try db.collection("schedule2").addDocument(from: schedule)
            } else {
                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: schedule)
            }
        } catch {
            print("error")
        }
        
        /*do {
            try db.collection("activity").addDocument(from: activity)
        } catch {
            print("error saving activity to DB")
        }*/
    }
        
    
    
}
