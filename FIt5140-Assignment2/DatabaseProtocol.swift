//
//  DatabaseProtocol.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 12/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    case all
    case BarometricData
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onBarometricChange(change: DatabaseChange, BarometricData: [Barometric])
}

protocol DatabaseProtocol: AnyObject {
   // func addNewBarometricData(date: Date, pressure: Double, attitude: Double, temperature: Double)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
