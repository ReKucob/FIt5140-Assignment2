//
//  ViewController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 11/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DatabaseListener{
    
    weak var firebaseMeter: DatabaseProtocol?
    var baroDataList: [Barometric] = []
    var listenerType: ListenerType

    @IBOutlet weak var temperatureField: UILabel!
    @IBOutlet weak var pressureField: UILabel!
    @IBOutlet weak var attitudeField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (baroDataList != []){
            temperatureField.text! = String(format:"%f",baroDataList.last!.temperature!);
            pressureField.text! = String(format: "%f",baroDataList.last!.pressure!);
            attitudeField.text! = String(format:"%f",baroDataList.last!.attitude!);
        
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseMeter?.addListener(listener:self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseMeter?.addListener(listener: self)
    }
    
    
    func onBarometricChange(change: DatabaseChange, BarometricData: [Barometric]) {
        
    }
    
    
}

