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
            }.onAppear() {
                loadScheduleFromFirestore()
            }
            .navigationBarTitle(currentSchedule.scheduleTitel)
            .navigationBarItems(trailing: Button(action: {
                print("save activity")
                showingAddActivitySheet = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddActivitySheet){
                AddActivitySheet(currentSchedule: currentSchedule)
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
                            self.currentSchedule = schedule
                            print("\(schedule.monday.activities[0])")
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
    @State var listOfActivities: [Activity]
    //@State var isEditable = false
    var db = Firestore.firestore()
    
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
                //.onMove(perform: move)
            }
        }
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        listOfActivities.move(fromOffsets: source, toOffset: destination)
    }
}

