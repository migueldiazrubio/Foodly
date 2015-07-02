//
//  RestaurantViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit
import MapKit

class RestaurantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var restaurant : Restaurant?

    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = restaurant?.title
        self.tableView.delegate = self
        let addDishButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addDish"))
        self.navigationItem.rightBarButtonItem = addDishButton
        
        let coordinate2D = CLLocationCoordinate2D(latitude: restaurant!.latitude, longitude: restaurant!.longitude)
        
        let currentRegion = MKCoordinateRegion(center: coordinate2D, span: MKCoordinateSpanMake(0.005, 0.005))
        
        mapView.region = currentRegion
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate2D
        annotation.title = restaurant?.title
        mapView.addAnnotation(annotation)
        
        streetLabel.text = restaurant?.address
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func addDish() {
        self.performSegueWithIdentifier("addDish", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addDish" {
            let destinationVC = segue.destinationViewController as! UINavigationController
            let addDishVC = destinationVC.topViewController as! AddDishViewController
            addDishVC.restaurant = restaurant
        }
        
        if segue.identifier == "viewImage" {
            let destinationVC = segue.destinationViewController as! ViewImageViewController
            let dishSelected = self.restaurant?.dishes[self.tableView.indexPathForSelectedRow!.row]
            destinationVC.dish = dishSelected!
        }
        
    }
    
    init (restaurant: Restaurant) {
        super.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* UITableViewDataSource */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant!.dishes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Se puede usar as sin ? ni ! porque el método
        // deque siempre va a devolver una celda, que 
        // sera de la clase o una subclase de
        // UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("DishCell", forIndexPath: indexPath) as! DishCell
        
        let dish = restaurant?.dishes[indexPath.row]
        cell.dish = dish
        cell.dishImage.layer.cornerRadius = 8.0
        cell.dishImage.clipsToBounds = true
        cell.dishImage.layer.borderWidth = 0.5
        cell.dishImage.layer.borderColor = UIColor.darkGrayColor().CGColor
        
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            restaurant?.dishes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            // Primero hacerlo con reloadData y luego contar el método deleteRows...
//            tableView.reloadData()
            
        }
        
    }

}
