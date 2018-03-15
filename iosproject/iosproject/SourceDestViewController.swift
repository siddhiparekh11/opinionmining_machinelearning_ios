//
//  ViewController.swift
//  mapkit
//
//  Created by Siddhi Parekh on 9/26/17.
//  Copyright © 2017 Siddhi Parekh. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI
import Foundation

class ViewController: UIViewController {
    
    var places = [String]()
    
    
    /* @IBOutlet var fromAddress: UITextField!
     @IBOutlet var fromCity: UITextField!
     @IBOutlet var fromState: UITextField!
     @IBOutlet var fromZip: UITextField!
     
     @IBOutlet weak var distanceText: UITextField!
     
     
     @IBOutlet var toAddress: UITextField!
     @IBOutlet var toCity: UITextField!
     @IBOutlet var toState: UITextField!
     @IBOutlet var toZip: UITextField!*/
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func geocode(_ sender: Any) {
        let address = fromCity.text!
        let fromplace = fromCity.text
        let toplace = toCity.text
        places.append(fromplace!)
        places.append(toplace!)
        
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
            }
        })
        
        
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var fromPlace = fromAddress.text! + ", " + fromCity.text!
        fromPlace += ", " + fromState.text! + ", " + fromZip.text! + ", USA"
        var toPlace = toAddress.text! + ", " + toCity.text!
        toPlace += ", " + toState.text! + ", " + toZip.text! + ", USA"
        
        if let destinationVC = segue.destination as? MapViewController {
            destinationVC.fromPlace = fromPlace
            destinationVC.toPlace = toPlace
            if segue.identifier == "ShowMap" { //show Map
                destinationVC.showType = "map"
            } else if segue.identifier == "ShowRoute" { //show Route
                destinationVC.showType = "route"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

