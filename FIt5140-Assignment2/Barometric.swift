//
//  Barometric.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 12/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class Barometric: NSObject {
    var pressure: Double?
    var attitude: Double?
    var temperature: Double?
    var maxT: Double?
    var minT: Double?

    init(newPressure: Double, newAttitude: Double, newTempature: Double, newMax: Double, newMin: Double) {
        self.pressure = newPressure
        self.attitude = newAttitude
        self.temperature = newTempature
        self.maxT = newMax
        self.minT = newMin
    }
}
