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
    var rgbRef: CollectionReference?
    var BarometricSensorDataList:[Barometric]
    var RGBSensorDataList:[RGBcolor]

    
    override init() {
        authController = Auth.auth()
        database = Firestore.firestore()
        BarometricSensorDataList = [Barometric]()
        RGBSensorDataList = [RGBcolor]()
        
        super.init()
        
        authController.signInAnonymously(){(authResult,error) in
            guard authResult != nil else{
                fatalError("Firebase athentication failes")
            }
            self.setUpListeners()
        }
    }
    
    func setUpListeners(){
        barometricRef = database.collection("sensors")
        barometricRef?.addSnapshotListener{(querySnapshot,error) in
           guard (querySnapshot?.documents) != nil
            else
            {
            print("Error fetching documents:\(error!)")
                return
            }
            self.parseBarometricSnapshot(snapshot: querySnapshot!)
    }
        rgbRef = database.collection("rgb")
        rgbRef?.addSnapshotListener{(querySnapshot,error) in
            guard querySnapshot?.documents != nil
            else
            {
                print("Error fetching documents of rgb color: \(error!)")
                return
            }
            self.parseRGBSnapshot(snapshot: querySnapshot!)
        }
    }
    
    func parseBarometricSnapshot(snapshot: QuerySnapshot) {
        
        snapshot.documentChanges.forEach{ change in
        
        let documentRef = change.document.documentID
        let attitude = change.document.data()["altitude"] as! Double
        let pressure = change.document.data()["pressure"] as! Double
        let temperature = change.document.data()["temperature"] as! Double
        print(documentRef)
        
            
            if change.type == .added{
                print("New sensor data: \(change.document.data())")
                let newSensorData = Barometric(newPressure: pressure,newAttitude: attitude, newTempature: temperature)
                
                BarometricSensorDataList.append(newSensorData)
                
            }
            
            if change.type == .modified{
                print("New sensor data: \(change.document.data())")
                let newSensorData = Barometric(newPressure: pressure,newAttitude: attitude, newTempature: temperature)
            
                BarometricSensorDataList.last!.attitude = newSensorData.attitude
                BarometricSensorDataList.last!.pressure = newSensorData.pressure
                BarometricSensorDataList.last!.temperature = newSensorData.temperature
                
                
            }
    }
        listeners.invoke{(listener) in
            if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.BarometricData{
                listener.onBarometricChange(change: .update, BarometricData: BarometricSensorDataList)
            }
        }
}
    
    func parseRGBSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach{ change in
        
        let documentRGB = change.document.documentID
            let red = change.document.data()["red"] as! Float
            let green = change.document.data()["green"] as! Float
            let blue = change.document.data()["blue"] as! Float
        print(documentRGB)
            
            if change.type == .added{
                print("New RGB Data: \(change.document.data())")
                let newRGBData = RGBcolor(newRed: red, newGreen: green, newBlue: blue)
            
                RGBSensorDataList.append(newRGBData)
            }
            
            if change.type == .modified{
                print("New RGB Data: \(change.document.data())")
                    let newRGBData = RGBcolor(newRed: red, newGreen: green, newBlue: blue)
                
                RGBSensorDataList.last!.red = newRGBData.red
                RGBSensorDataList.last!.green = newRGBData.green
                RGBSensorDataList.last!.blue = newRGBData.blue
            
            }
            
        }
        
        listeners.invoke{(listener) in
            if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.RGBData{
                listener.onRGBChange(change: .update, RGBData: RGBSensorDataList)
            }
        }
        
    }
    
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.BarometricData{
            listener.onBarometricChange(change: .update, BarometricData: BarometricSensorDataList)
        }
        
        if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.RGBData{
            listener.onRGBChange(change: .update, RGBData: RGBSensorDataList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
}
