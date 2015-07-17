//
//  AddRestaurantViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 27/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddRestaurantViewController: UIViewController, CLLocationManagerDelegate {
    
    var foodlyManager = FoodlyManager.sharedInstance
    
    var locationManager : CLLocationManager?
    var userLocation : CLLocation?
    var userLocationDescription : String?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func save(sender: AnyObject) {
        locationManager!.stopUpdatingLocation()
        
        if textField.text != "" && userLocation != nil && userLocationDescription != "" {
            
            foodlyManager.addRestaurant(textField.text!, latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, address: userLocationDescription!)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Debe introducir un nombre para el restaurante y su localización", preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)

            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        locationManager!.stopUpdatingLocation()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()

        // Primero poner startUpdatingLocation
        // y luego hablar del nuevo método y utilizarlo
        // solo en iOS 9 con #available de Swift 2
        if #available(iOS 9.0, *) {
            locationManager!.requestLocation()
        } else {
            locationManager!.startUpdatingLocation()
        }
    }
    
    /* CLLocationManagerDelegate */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error.description)
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last {
            
            userLocation = currentLocation

            let currentRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpanMake(0.005, 0.005))
            
            mapView.region = currentRegion

            CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in

                if placemarks!.count > 0 {
                    let pm = placemarks!.last
                    self.userLocationDescription = pm!.locality
                }
            
            })
                        
            textField.becomeFirstResponder()
            
        }
        
    }
}
