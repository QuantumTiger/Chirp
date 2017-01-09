//
//  BirdMapViewController.swift
//  Chirp
//
//  Created by WGonzalez on 12/15/16.
//  Copyright © 2016 Quantum Apple. All rights reserved.
//

import UIKit
import MapKit

class BirdMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var birdMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var latitude = ""
    var longitude = ""
    var location = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Location
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let coordinates = latitude + ", " + longitude
        geoCodeLocation(Location: coordinates)
    }
    
    func geoCodeLocation(Location: String)
    {
        let myGeoCode = CLGeocoder()
        myGeoCode.geocodeAddressString(Location) { (placeMarks, error) -> Void in
            if error != nil
            {
                print("Error")
            }
            else
            {
                //Calls on the function to display on the map
                self.displayMap(MyPlaceMark: (placeMarks?.first)!)
            }
        }
    }
    
    //Creates a pin of the location selected by the user
    func displayMap(MyPlaceMark: CLPlacemark)
    {
        let myPin = MKPointAnnotation()
        location = MyPlaceMark.name!
        let myLocation = MyPlaceMark
        let span = MKCoordinateSpanMake(15, 15)
        let region = MKCoordinateRegionMake((myLocation.location?.coordinate)!, span)
        birdMap.setRegion(region, animated: true)
        myPin.coordinate = (myLocation.location?.coordinate)!
        myPin.title = MyPlaceMark.name
        birdMap.addAnnotation(myPin)
    }


    
}
