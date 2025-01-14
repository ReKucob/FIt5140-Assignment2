//
//  ChartViewController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 30/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController,DatabaseListener {
    
    @IBOutlet weak var lineviewChart: LineChartView!
    @IBOutlet weak var ChartViewLine: LineChartView!
   
    var baroDataList: [Barometric] = []
    weak var firebaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseController!.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseController!.removeListener(listener: self)
    }
    
    var listenerType = ListenerType.BarometricData
     
     func onBarometricChange(change: DatabaseChange, BarometricData: [Barometric]) {
         baroDataList = BarometricData
        var lineChartEntry = [ChartDataEntry]()
        
        for data in baroDataList{
            let xvalue1 = lineChartEntry.count + 1
            let value = ChartDataEntry(x: Double(xvalue1), y: data.temperature!)
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "temperature")
        line.colors = [NSUIColor.blue]
        
        let stat = LineChartData()
        stat.addDataSet(line)
        
        lineviewChart.data = stat
        lineviewChart.chartDescription?.text = "Charts test"
        
        var chartlineEntry = [ChartDataEntry]()
        
        for data in baroDataList{
            let xvalue2 = chartlineEntry.count + 1
            let value2 = ChartDataEntry(x: Double(xvalue2), y: data.pressure!)
            
            chartlineEntry.append(value2)
        }
        
        let line2 = LineChartDataSet(entries: chartlineEntry, label: "Pressure")
        line2.colors = [NSUIColor.purple]
        
        let stat2 = LineChartData()
        stat2.addDataSet(line2)
        
        ChartViewLine.data = stat2
        ChartViewLine.chartDescription?.text = "Pressure"
        
     }
     
     func onRGBChange(change: DatabaseChange, RGBData: [RGBcolor]) {
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
