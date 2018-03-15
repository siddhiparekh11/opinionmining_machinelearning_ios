//
//  ViewController.swift
//  MapComp
//
//  Created by Poornima Srikantesh on 12/6/17.
//  Copyright © 2017 CMPE297. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , UISearchBarDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    //@IBOutlet weak var mapView: MKMapView!
    
   // @IBAction func searchButton(_ sender: Any) {
   // }
    
   // @IBAction func localSearch(_ sender: Any) {
    //}
    //@IBOutlet weak var searchText: UITextField!
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
    
   // @IBOutlet weak var mapView: MKMapView!
    
    
    
    var myPin=CustomPointAnnotation()
    // var myPin2=CustomPointAnnotation()
    
    @IBOutlet weak var searchText: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var locationManager = CLLocationManager()
    @IBAction func searchButton(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true,completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //HIde search bar
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        
        //create search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start{(response, Error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil
            {
                print("Error")
            }
            else
            {
                //Remove annotations
                // let annotations = self.mapView.annotations
                //self.mapView.removeAnnotations(annotations)
                
                //get data
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                
                
                let myCoord = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myPin.coordinate = myCoord
                //self.myMapView.delegate = self
                self.myPin.title=searchBar.text
                self.myPin.imageName = "image2.png"
                self.mapView.addAnnotation(self.myPin)
                
                //let annotation = MKPointAnnotation()
                // annotation.title = searchBar.text
                //annotation.coordinate = CLLocationCoordinate2DMake(latitude!,longitude!)
                
                //  self.myMapView.addAnnotation(annotation)
                
                //zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.03, 0.03)
                let region = MKCoordinateRegionMake(coordinate,span)
                self.mapView.setRegion(region, animated: true)
            }
        }
        
    }
    
    
    
    
    @IBAction func localSearch(_ sender: Any) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    //  print("Name = \(item.name)")
                    // print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    //let annotation = MKPointAnnotation()
                    //annotation.coordinate = item.placemark.coordinate
                    //annotation.title = item.name
                    //self.mapView.addAnnotation(annotation)
                    
                    //let myCoord2 = item.placemark.coordinate
                    
                    // var myPin2=CustomPointAnnotation()
                    
                    let myPin2 = CustomPointAnnotation()
                    myPin2.coordinate = item.placemark.coordinate
                    //self.myMapView.delegate = self
                    myPin2.title=item.name
                    myPin2.imageName = "image2.png"
                    self.mapView.addAnnotation(myPin2)
                }
            }
        })
        matchingItems.removeAll()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            print("NOT REGISTERED AS MKPOINTANNOTATION")
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myMapIdentitfier")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "myMapIdentitfier")
            annotationView!.canShowCallout = true
        }
            
        else {
            annotationView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        annotationView!.image = UIImage(named: cpa.imageName)
        
        return annotationView
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


