//
//  ViewController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 11/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DatabaseListener{
    
    weak var firebaseController: DatabaseProtocol?
    var baroDataList: [Barometric] = []
    

    @IBOutlet weak var temperatureField: UILabel!
    @IBOutlet weak var pressureField: UILabel!
    @IBOutlet weak var attitudeField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController

        if (baroDataList != []){
            temperatureField.text! = String(format:"%f",baroDataList.last!.temperature!);
            pressureField.text! = String(format: "%f",baroDataList.last!.pressure!);
            attitudeField.text! = String(format:"%f",baroDataList.last!.attitude!);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseController!.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseController!.removeListener(listener: self)
    }
    
    //  MARK: - Database Listener
    
    var listenerType = ListenerType.BarometricData
    
    func onBarometricChange(change: DatabaseChange, BarometricData: [Barometric]) {
    }

}


