//
//  ContentView.swift
//  KidsSchedule
//
//  Created by Sara Kluge on 2021-01-28.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var db = Firestore.firestore()
    @State var currentSchedule = Schedule()
    @State var showingAddActivitySheet = false
    
    var body: some View {
        
        NavigationView{
            HStack{
                DayView(dayName: "Måndag", listOfActivities: currentSchedule.monday.activities)
                DayView(dayName: "Tisdag", listOfActivities: currentSchedule.tuesday.activities)
                DayView(dayName: "Onsdag", listOfActivities: currentSchedule.wednesday.activities)
                DayView(dayName: "Torsdag", listOfActivities: currentSchedule.thursday.activities)
                DayView(dayName: "Fredag", listOfActivities: currentSchedule.friday.activities)
                DayView(dayName: "Lördag", listOfActivities: currentSchedule.saturday.activities)
                DayView(dayName: "Söndag", listOfActivities: currentSchedule.sunday.activities)
                
            }.navigationBarTitle(currentSchedule.scheduleTitel)
            .navigationBarItems(trailing: Button(action: {
                print("save activity")
                showingAddActivitySheet = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddActivitySheet){
                AddActivitySheet()
            }
        }
    }
  
    func loadScheduleFromFirestore() {
        db.collection("schedule").addSnapshotListener { (snapshot, err) in
            if let err = err{
                print("error getting document \(err)")
            } else {
                for document in snapshot!.documents{
                    
                    let result = Result {
                        try document.data(as: Schedule.self)
                    }
                    switch result {
                    case .success(let schedule):
                        if let schedule = schedule {
                            print("\(schedule)")
                        } else {
                            print("document does not exist")
                        }
                    case .failure(let error):
                        print("error decoding schedule: \(error)")
                    }
                }
            }
        }
    }
    
}
    
    
    
    
   /* func getColor(dayName: String) {
        switch dayName {
        case "Måndag":
            print("green")
        case "Tisdag":
            print("blue")
        case "Onsdag":
            print("White")
        case "Torsdag":
            print("brown")
        case "Fredag":
            print("Yellow")
        case "Lördag":
            print("Pink")
        case "Söndag":
            print("red")
        default :
            print("defualt")
            
        }
    }*/




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
            
            
    }
}

struct DayView: View {
    var dayName: String
    var listOfActivities: [Activity]
    
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color.blue)
                    .frame(width:100, height: 50, alignment: .center)
                Text(dayName)
                    .bold()
            }
            List(){
                ForEach(listOfActivities){activity in
                    Text(activity.title)
            
                }
            }
        }
    }
    
}

struct AddActivitySheet: View {
    
    var listOfDays = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
    @State var selectedDay = "Måndag"
    @State var title = ""
    @State var time = ""
    @State var location = ""
    var db = Firestore.firestore()
    @Environment(\.presentationMode) var presentationMode
    
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
        //let day = Day()
        let schedule = Schedule()
        
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
