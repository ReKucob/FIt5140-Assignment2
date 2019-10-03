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
    @IBOutlet weak var ImageField1st: UIImageView!
    @IBOutlet weak var SecondImageFIeld: UIImageView!
    @IBOutlet weak var minField: UILabel!
    @IBOutlet weak var maxField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        
        self.view.insertSubview(background, at: 0)
        
    }
    
    @IBOutlet weak var background: UIImageView!
    
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
        temperatureField.text! = String(format:"%.2f",baroDataList.last!.temperature!) + "°C";
        pressureField.text! = String(format: "%.2f",baroDataList.last!.pressure!);
        attitudeField.text! = String(format:"%.2f",baroDataList.last!.attitude!);
        maxField.text! = String(format: "%.2f", baroDataList.last!.maxT!);
        minField.text! = String(format: "%.2f", baroDataList.last!.minT!);
        }
    }
    
    func onRGBChange(change: DatabaseChange, RGBData: [RGBcolor]) {
        RGBDataList = RGBData
        
        let number = Int.random(in: 0 ..< 10)


        if (number == 0){
            ImageField1st.setImageColor(color: UIColor(red: CGFloat(RGBDataList.last!.red!/255.0), green: CGFloat(RGBDataList.last!.green!/255.0), blue: CGFloat(RGBDataList.last!.blue!/255.0),alpha: 1.0))
            SecondImageFIeld.setImageColor(color: UIColor(red: 255, green: 255, blue: 0,alpha: 1.0))
        }

        if (number == 1)
        {
            SecondImageFIeld.setImageColor(color: UIColor(red: CGFloat(RGBDataList.last!.red!/255.0), green: CGFloat(RGBDataList.last!.green!/255.0), blue: CGFloat(RGBDataList.last!.blue!/255.0),alpha: 1.0))
            ImageField1st.setImageColor(color: UIColor(red: 0, green: 255, blue: 255,alpha: 1.0))
        }
        
       
       }

}

extension UIImageView {
    func setImageColor(color: UIColor)
    
    {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

