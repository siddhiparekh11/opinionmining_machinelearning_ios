//
//  PieChartController.swift
//  iosproject
//
//  Created by Siddhi Parekh on 12/8/17.
//  Copyright © 2017 Siddhi Parekh. All rights reserved.
//

import Foundation
import UIKit
import Charts

class PieChartController: UIViewController {
    @IBOutlet var pieChart: PieChartView!
    
    var intPassed = Int()
    var data1=[Double]()
    var status = ["Neutral","Negative","Positive"]
   
    override func viewDidLoad() {
        super.viewDidLoad();
      //  var data = [89.34,83.06,27.59] // pie chart data
       // var data = [24.5,50.0,24.5]
        // status
        //var data = [25.0,37.5,12.5,12.5,12.5] // pie chart data
        //var status = ["A","B","C","D","E"] // status
        setChart(dataPoints: status, values: data1)
        self.pieChart.drawSliceTextEnabled = false
        self.pieChart.drawEntryLabelsEnabled=false
        
        print(intPassed)
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
        
        pieChart.noDataText = "you need to provide data for chart"
        
        
        self.pieChart.descriptionText = ""
        
        //var dataEntries: [ChartDataEntry] = []
        var dataEntries: [PieChartDataEntry] = []
        //pieChart.centerText = " "
        for i in 0..<dataPoints.count {
            
           // let dataEntry = PieChartDataEntry(x: Double(i),y: values[i])
            let dataEntry = PieChartDataEntry(value: values[i],label: status[i])
            
            dataEntries.append(dataEntry)
            
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Sentiments")
        
        
        var colors: [UIColor] = []
        
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
            
            pieChartDataSet.colors = colors
            
        }
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChart.centerText = "Airline Sentiment Analysis"
        pieChart.data = pieChartData
       // pieChart.animate(yAxisDuration: 2.0, easingOption: .easeInBack)
    }

    }
    

