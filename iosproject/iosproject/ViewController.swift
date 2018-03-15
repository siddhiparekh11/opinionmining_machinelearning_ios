//
//  ViewController.swift
//  iosproject
//
//  Created by Siddhi Parekh on 11/28/17.
//  Copyright © 2017 Siddhi Parekh. All rights reserved.
//

import UIKit
import Foundation
import CoreML



import CSVImporter

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var pickerui: UIPickerView!
   var pickerdata=["united","virginamerica","delta","american","southwest","usairways","default"]
    var path:String!
    
      let model=twitter()
    var arr=[Double]()
    @IBAction func onPredict(_ sender: UIButton) {
        
        var m1 = MultiArray<Double>(shape:[2928,11919])
        var m=[[Double]]()
       // path = "/Users/siddhiparekh11/Desktop/united.csv"
        // var i=0
        // var j=0
        let importer = CSVImporter<[String]>(path: path, delimiter: ",")
        print(path)
        importer.startImportingRecords { $0 }.onFail {
            
            print("The CSV file couldn't be read.")
            
            }.onFinish { importedRecords in
                
                for record in importedRecords {
                    // record is of type [String] and contains all data in a line
                    //  print(record.count)
                    for str in record{
                        var strArr=str.components(separatedBy: ",")
                        // j=0
                        m.append(strArr.map{ NSString(string: $0).doubleValue })
                        
                        /* for r in strArr{
                         m[i][j]=Double(r)
                         j=j+1
                         m.
                         }*/
                    }
                    //i=i+1
                    //  print(m.count)
                    
                }
        }
        for x in 0 ..< m.count {
            for y in 0 ..< m[x].count {
                m1[x,y]=m[x][y]
            }
        }
        print(m1.count)
        let coreMLArray:MLMultiArray=m1.array
        let pred=try?model.prediction(input:coreMLArray)
        print(pred?.classProbability)
        
        var i=0
        for(key,value) in (pred?.classProbability)!{
            arr.append(round(value*100)/100)
            print(arr[i])
            i=i+1
        }
       
        
    }
    

    

    override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
       pickerui.delegate = self
        pickerui.dataSource = self
        path="/Users/siddhiparekh11/Desktop/united.csv"
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerdata.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       
      return pickerdata[row]
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(row)
        if(row==0)
        {
            path = "/Users/siddhiparekh11/Desktop/united.csv"
        }
        else if(row==1)
        {
            path = "/Users/siddhiparekh11/Desktop/virginamerica.csv"
        }
        else if(row==2)
        {
            path = "/Users/siddhiparekh11/Desktop/delta.csv"
        }
        else if(row==3)
        {
            path = "/Users/siddhiparekh11/Desktop/americanair.csv"
        }
        else if(row==4)
        {
            path = "/Users/siddhiparekh11/Desktop/southwest.csv"
        }
        else if(row==5)
        {
            path = "/Users/siddhiparekh11/Desktop/usairways2.csv"
        }
        else if(row==6)
        {
            path = "/Users/siddhiparekh11/Desktop/feature_test.csv"
        }
      
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? PieChartController  {
            destinationViewController.intPassed=5
            destinationViewController.data1=arr
        }
    }

   


}

