//
//  FirebaseController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 12/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {

    
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database:Firestore
    var barometricRef: CollectionReference?
    var BarometricSensorDataList:[Barometric]

    
    override init() {
        authController = Auth.auth()
        database = Firestore.firestore()
        BarometricSensorDataList = [Barometric]()
        
        super.init()
        
        authController.signInAnonymously(){(authResult,error) in
            guard authResult != nil else{
                fatalError("Firebase athentication faileds")
            }
            self.setUpListeners()
        }
    }
    
    func setUpListeners(){
        barometricRef = database.collection("Barometric")
        barometricRef?.addSnapshotListener{querySnapshot,error in
           guard (querySnapshot?.documents) != nil
            else
            {
            print("Error fetching documengs:\(error!)")
                return
            }
            self.parseBarometricSnapshot(snapshot: querySnapshot!)
    }
    }
    
    func parseBarometricSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach{ change in
        let documentRef = change.document.documentID
        let date = change.document.data()["date"] as! Date
        let attritude = change.document.data()["attritude"] as! Double
        let pressure = change.document.data()["pressure"] as! Double
        let temperature = change.document.data()["temperature"] as! Double
        print(documentRef)
        
            
            if change.type == .added{
                print("New sensor data: \(change.document.data())")
                let newSensorData = Barometric(newTime: date, newPressure: pressure, newAttitude: attritude, newTempature: temperature)
                
                BarometricSensorDataList.append(newSensorData)
            }
    }
        listeners.invoke{(listener) in
            if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.BarometricData{
                listener.onBarometricChange(change: .update, BarometricData: BarometricSensorDataList)
    }
   }
}
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.BarometricData{
            listener.onBarometricChange(change: .update, BarometricData: BarometricSensorDataList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
}
