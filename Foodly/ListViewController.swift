//
//  ListViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var foodlyManager = FoodlyManager.sharedInstance
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.whiteColor()
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: Selector("iCloudUpdateUI"), name: "iCloudUpdateUI", object: nil)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    func iCloudUpdateUI() {
        print("UI updated")
        self.collectionView.reloadData()
    }
    
    @IBAction func trashSelectedElements(sender: AnyObject) {
        
        if let indexPaths = collectionView.indexPathsForSelectedItems() as [NSIndexPath]? {
            
            for indexPath in indexPaths {
                
                let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! RestaurantCell
                    
                // Borramos el modelo
                foodlyManager.deleteRestaurant(cell.restaurant!)
            
                // Borramos las celdas
                collectionView.deleteItemsAtIndexPaths([indexPath])
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    /* Edición */
    override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        
        addButtonItem.enabled = !editing
        collectionView!.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems() as [NSIndexPath]!
        for indexPath in indexPaths {
            collectionView!.deselectItemAtIndexPath(indexPath, animated: false)
            let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! RestaurantCell
            cell.editing = editing
            
        }
        
        toolBar.hidden = !editing
        
    }
   
    /* UICollectionViewDelegate */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if !editing {
            
            if segue.identifier == "detailSegue" {

                if let selectedIndex = collectionView.indexPathsForSelectedItems()?.last {

                    let cell = collectionView.cellForItemAtIndexPath(selectedIndex) as! RestaurantCell
                    let restaurant : Restaurant = cell.restaurant!
                    let vc = segue.destinationViewController as! RestaurantViewController
                    vc.restaurant = restaurant
                }
            
            }

        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if !editing {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! RestaurantCell
            performSegueWithIdentifier("detailSegue", sender: cell)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let restaurants = foodlyManager.restaurants() {
            return restaurants.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("restaurantCell", forIndexPath: indexPath) as! RestaurantCell

        cell.restaurant = foodlyManager.restaurants()![indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        
        cell.imageView.image = UIImage(named: "no-picture")
        let dishes = cell.restaurant?.dishes?.allObjects as! [Dish]
        if dishes.count > 0 {
            cell.imageView.image = UIImage(data: dishes[0].image!)
        }
        cell.imageView.layer.borderWidth = 0.5
        cell.imageView.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.imageView.layer.cornerRadius = 8.0
        cell.imageView.clipsToBounds = true
        
        // Para la edición
        cell.editing = editing
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize = self.view.frame.size
        
        var colsForRow : Int = 2
        if screenSize.width >= 414.0 {
            colsForRow = 3
        }
        if screenSize.width >= 768.0 {
            colsForRow = 6
        }
        
        let cellWidth = (Int(screenSize.width) - ((colsForRow * 20) + 20)) / colsForRow

        return CGSizeMake(CGFloat(cellWidth), CGFloat(cellWidth + 30))
        
    }
        
}