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
    var RGBDataList: [RGBcolor] = []
    

    @IBOutlet weak var temperatureField: UILabel!
    @IBOutlet weak var pressureField: UILabel!
    @IBOutlet weak var attitudeField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        
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
    
    var listenerType = ListenerType.all
    
    func onBarometricChange(change: DatabaseChange, BarometricData: [Barometric]) {
        baroDataList = BarometricData
        
        if (!baroDataList.isEmpty){
        temperatureField.text! = String(format:"%f",baroDataList.last!.temperature!);
        pressureField.text! = String(format: "%f",baroDataList.last!.pressure!);
        attitudeField.text! = String(format:"%f",baroDataList.last!.attitude!);
        }
    }
    
    func onRGBChange(change: DatabaseChange, RGBData: [RGBcolor]) {
        RGBDataList = RGBData
        
        if (!RGBDataList.isEmpty){
            self.view.backgroundColor = UIColor(red: CGFloat(RGBDataList.last!.red!/255.0), green: CGFloat(RGBDataList.last!.green!/255.0), blue: CGFloat(RGBDataList.last!.blue!/255.0),alpha: 1.0)
        }
       }

}


