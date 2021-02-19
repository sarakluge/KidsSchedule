//
//  AddAndEditActivityView.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-02-19.
//

import Foundation
import SwiftUI
import Firebase

struct AddAndEditActivityView: View {
    
    var listOfDays = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
    @State var selectedDay = "Måndag"
    @State var title = ""
    @State var time = ""
    @State var location = ""
    var db = Firestore.firestore()
    
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
                Button(action: {addActivityToFirestore(selectedDay: selectedDay, title: title, time: time, location: location)}) {
                    Text("Spara")
                }
                
            }
        }
    }
    
    func addActivityToFirestore(selectedDay: String, title: String, time: String, location: String) {
        let activity = Activity(title: title, time: time, location: location)
        //let day = Day()
        let schedule = Schedule()
        schedule.monday.activities.append(activity)
        
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
            try db.collection("schedule").addDocument(from: schedule)
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
