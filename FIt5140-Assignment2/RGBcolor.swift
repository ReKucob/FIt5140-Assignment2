//
//  RGBcolor.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 27/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class RGBcolor: NSObject {

    var red: Float?
    var green: Float?
    var blue: Float?
    
    init(newRed: Float, newGreen: Float, newBlue: Float) {
        self.red = newRed
        self.green = newGreen
        self.blue = newBlue
    }
}
