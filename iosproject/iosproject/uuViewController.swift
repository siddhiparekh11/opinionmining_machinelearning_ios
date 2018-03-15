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

class uuViewController: UIViewController {
    
    var places = [String]()
    
    @IBOutlet weak var fromcity: UITextField!
    
    @IBOutlet weak var geocode: UIButton!
    @IBOutlet weak var tocity: UITextField!
  //   @IBOutlet var fromAddress: UITextField!
    // @IBOutlet var fromCity: UITextField!
     //@IBOutlet var fromState: UITextField!
     //@IBOutlet var fromZip: UITextField!
     
   //  @IBOutlet weak var distanceText: UITextField!
     
     
    // @IBOutlet var toAddress: UITextField!
     //@IBOutlet var toCity: UITextField!
     //@IBOutlet var toState: UITextField!
     //@IBOutlet var toZip: UITextField!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   /* @IBAction func geocode(_ sender: Any) {
        
        
        
    }*/
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let address = fromcity.text!
        let fromplace = fromcity.text
        let toplace = tocity.text
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
        var fromPlace = fromcity.text!
        var toPlace = tocity.text!
        
        if let destinationVC = segue.destination as? DistanceViewController {
            destinationVC.fromPlace = fromPlace
            destinationVC.toPlace = toPlace
            //if segue.identifier == "ShowMap" { //show Map
              //  destinationVC.showType = "map"
             //segue.identifier == "ShowRoute" //{ //show Route
                destinationVC.showType = "route"
           // }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


