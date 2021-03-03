//
//  AddAndEditActivity.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-02-23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

struct AddActivitySheet: View {
    
    var listOfDays = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
    var listOfImage = ["book", "school", "basketball", "bike", "calculator", "carts", "cinema", "dance", "forest", "friends", "friendship", "gamecontroller", "gift", "hockey", "home", "ipad", "iphone", "museum", "notebook", "papercrafts", "pencils", "soccer", "sports", "swim", "test", "theater", "tv"]
    @State var selectedImage = ""
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
                Picker(selection: $selectedImage, label: Text("Välj en bild")){
                    ForEach(listOfImage, id: \.self) { image in
                        Image( "\(image)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                }
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
                    }.buttonStyle(PlainButtonStyle())
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button("Ångra"){
                        self.presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                }
            }
        }
    }
    
    func addActivityToFirestore(selectedDay: String, title: String, time: String, location: String) {
        let activity = Activity(title: title, time: time, location: location, imageName: selectedImage)
        let userId = Auth.auth().currentUser?.uid
        let schedule = currentSchedule
        schedule.userId = userId
        
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
                try db.collection("schedule3").addDocument(from: schedule)
            } else {
                if let currentScheduleDocId = currentSchedule.docId{
                    try db.collection("schedule3").document(currentScheduleDocId).setData(from: schedule)
                }
            }
        } catch {
            print("error")
        }
    }
}
