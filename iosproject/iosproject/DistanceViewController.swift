//
//  DistanceViewController.swift
//  iosproject
//
//  Created by Siddhi Parekh on 12/8/17.
//  Copyright © 2017 Siddhi Parekh. All rights reserved.
//

import Foundation

//
//  MapViewController.swift
//
//  Created by Siddhi Parekh on 9/26/17.
//  Copyright © 2017 Siddhi Parekh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//How to know where user are
import CoreLocation

class DistanceViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var abctext: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var abctext: UITextField!
    //Display string for address map
    var fromPlace = ""
    var toPlace = ""
    var showType = "" //either "map" or "route"
    var geocoder = CLGeocoder()
    var places = [String]()
    //var location1: CLLocationDegrees = 37.2
    //var location2: CLLocationDegrees = 22.9
    @IBOutlet weak var distanceText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a
    }
    
    func routes(to item: MKMapItem, completion: @escaping ([MKRoute]?, Error?) -> Void) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = item
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            completion(response?.routes, error)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if showType == "map" {
        print("fromPlace = " + fromPlace)
        print("toPlaceyy = " + toPlace)
        if (!fromPlace.isEmpty) {
            places.append(fromPlace)
        }
        if (!toPlace.isEmpty) {
            places.append(toPlace)
        }
       /* if showType == "map" {
            mapPlot(places, polyline: false) //Map plots
        } else if showType == "route" {*/
            mapPlot(places, polyline: true) //Map plots
       // }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Helper function to map plot on map
    func mapPlot(_ places:[String], polyline:Bool) {
        var loc11 = CLLocation(latitude: 1, longitude: 2)
        var loc22 = CLLocation(latitude: 1, longitude: 2)
        
        var i = 1
        var coordinates: CLLocationCoordinate2D?
        var loc1 = CLLocation(latitude: 1, longitude: 2)
        var loc2 = CLLocation(latitude:3, longitude: 4)
        var placemark: CLPlacemark?
        var annotation: Station?
        var stations:Array = [Station]()
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        var count = 0
        for address in places {
            geocoder = CLGeocoder() //new geocoder
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil)  {
                    print("Error", error)
                }
                placemark = placemarks?.first
                if placemark != nil {
                    coordinates = placemark!.location!.coordinate
                    points.append(coordinates!)
                    print("locations = \(coordinates!.latitude) \(coordinates!.longitude)")
                    
                    annotation = Station(latitude: coordinates!.latitude, longitude: coordinates!.longitude, address: address)
                    stations.append(annotation!)
                    print(stations.count)
                    print(i)
                    
                    
                    
                    
                    if( count == 0)
                        
                    {
                        loc11 = CLLocation(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
                    }
                    else if(count == 1)
                    {
                        loc22 = CLLocation(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
                    }
                    
                    
                    // loc2 = CLLocation(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
                    
                    count = count  + 1
                    
                    //var doubleDistText = Double(distanceText.text!)
                    
                    //self.abctext.text = stringDistance
                    
                    
                    
                    if (i == self.places.count) {
                        print("Print map...")
                        self.mapView.addAnnotations(stations)
                        //                        let region = MKCoordinateRegionMakeWithDistance(coordinates!, 7000.0, 7000.0)
                        //                        self.mapView.setRegion(region, animated: true)
                        if (polyline == true) { //If draw polyline is true
                            let line = MKPolyline(coordinates: &points, count: points.count)
                            self.mapView.add(line)
                        }
                    }
                    i += 1
                }
                let distance : CLLocationDistance = loc11.distance(from: loc22)
                print("distance = \(distance) m")
                
                let stringDistance = String(format:"%f",distance)
                self.abctext.text=stringDistance
                
            })
        }
    }
    
    
    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    class Station: NSObject, MKAnnotation {
        var title: String?
        var latitude: Double
        var longitude:Double
        
        var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        init(latitude: Double, longitude: Double, address: String) {
            self.latitude = latitude
            self.longitude = longitude
            self.title = address
        }
        
        
    }
}
