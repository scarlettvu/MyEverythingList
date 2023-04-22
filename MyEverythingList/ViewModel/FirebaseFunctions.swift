//
//  FireBasefunctions.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class FirebaseFunctions : ObservableObject{
    @Published var everythingList:[EverythingListModel] = []
    @Published var isCompleted = false
    init(){
        FetchData()
    }
    
    func UpdateTask(upDate:EverythingListModel){
        let db = Firestore.firestore()
        if upDate.isCompleted{
            db.collection("EverythingList").document(upDate.id).setData(["isCompleted":false], merge: true) { error in
                if error == nil{
                    withAnimation{
                        self.FetchData()
                    }
                }
            }
        }else{
            db.collection("EverythingList").document(upDate.id).setData(["isCompleted":true], merge: true) { error in
                if error == nil{
                    withAnimation{
                        self.FetchData()
                    }
                }
            }
        }
    }
    func DeletTask(toDelet:EverythingListModel){
        let db = Firestore.firestore()
        db.collection("EverythingList").document(toDelet.id).delete { error in
            if error == nil{
                self.everythingList.removeAll{ item in
                    return item.id == toDelet.id
                }
            }
        }
    }
    func SaveTask(titel:String,isCompled:Bool,icon:String){
        let db = Firestore.firestore()
        db.collection("EverythingList").addDocument(data: ["title":titel,"isCompleted":isCompled,"icon":icon]) { error in
            guard error == nil else{
                print("error")
                return
            }
            self.FetchData()
        }
    }
    func FetchData(){
        let db = Firestore.firestore()
        db.collection("EverythingList").getDocuments { snapshot, error in
            guard error == nil else{
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            if let snapshot = snapshot{
                self.everythingList = snapshot.documents.map{data in
                    return EverythingListModel(id: data.documentID, isCompleted: data["isCompleted"] as? Bool ?? false, title:  data["title"] as? String ?? "", icon:data["icon"] as? String ?? "")
                    
                }
            }
        }
    }
}
