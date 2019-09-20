//
//  ViewController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 11/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var barometers: Barometric?

    @IBOutlet weak var temperatureField: UILabel!
    @IBOutlet weak var pressureField: UILabel!
    @IBOutlet weak var attitudeField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (barometers != nil){
        temperatureField.text! = String(format:"%f",barometers!.temperature!);
        pressureField.text! = String(format: "%f",barometers!.pressure!);
        attitudeField.text! = String(format:"%f",barometers!.attitude!);
        
        }
        // Do any additional setup after loading the view.
    }
    
    


}

