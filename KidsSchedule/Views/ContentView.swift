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
            ZStack{
                Color(red: 43.0/256 , green: 42.0/256, blue: 43.0/256)
                
            HStack{
               /* DayView(dayName: "Måndag", listOfActivities: currentSchedule.monday.activities)
                DayView(dayName: "Tisdag", listOfActivities: currentSchedule.tuesday.activities)
                DayView(dayName: "Onsdag", listOfActivities: currentSchedule.wednesday.activities)
                DayView(dayName: "Torsdag", listOfActivities: currentSchedule.thursday.activities)
                DayView(dayName: "Fredag", listOfActivities: currentSchedule.friday.activities)
                DayView(dayName: "Lördag", listOfActivities: currentSchedule.saturday.activities)
                DayView(dayName: "Söndag", listOfActivities: currentSchedule.sunday.activities)*/
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.green)
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Måndag")
                            .bold()
                    }
                
                    List(){
                        ForEach(currentSchedule.monday.activities){activity in
                                Text(activity.title)
                        }
                        .onDelete(perform: { indexSet in
                            for index in indexSet {
                                currentSchedule.monday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.monday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Tisdag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.tuesday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.tuesday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.tuesday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Onsdag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.wednesday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.wednesday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.wednesday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 94.0/256 , green: 66.0/256, blue: 49.0/256))
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Torsdag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.thursday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.thursday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.thursday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 255.0/256 , green: 250.0/256, blue: 92.0/256))
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Fredag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.friday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.friday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.friday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 255.0/256 , green: 99.0/256, blue: 190.0/256))
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Lördag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.saturday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.saturday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.saturday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.red)
                            .frame(width:100, height: 50, alignment: .center)
                            .padding(.bottom, -4.0)
                        Text("Söndag")
                            .bold()
                    }
                    List(){
                        ForEach(currentSchedule.sunday.activities){activity in
                            Text(activity.title)
                    
                        }
                        .onDelete(perform: { indexSet in
                            
                            for index in indexSet {
                                currentSchedule.sunday.activities.remove(atOffsets: indexSet)
                                do {
                                    try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                    
                                } catch {
                                    print("error")
                                }
                            }
                        })
                        
                        .onMove { (indexSet, index) in
                            self.currentSchedule.sunday.activities.move(fromOffsets: indexSet, toOffset: index)
                            do {
                                try db.collection("schedule2").document(currentSchedule.docId!).setData(from: currentSchedule)
                                
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
            }.onAppear() {
                loadScheduleFromFirestore()
                anonymousAuth()
            }
            .navigationBarTitle(currentSchedule.scheduleTitel)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
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
    }
    
    func anonymousAuth() {
        Auth.auth().signInAnonymously() { (authResult, error) in
          if let authResult = error {
                print("Error occurred while logging in")
            } else {
                guard let user = authResult?.user else { return }
                let isAnonymous = user.isAnonymous  // true
                let uid = user.uid
            }
        }
    }
    
    
    func loadScheduleFromFirestore() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("schedule2")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (snapshot, err) in
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
            }
        }
    }
}

