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
    case temperature
    case attitude
    case pressure
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
}

protocol DatabaseProtocol: AnyObject {
}
