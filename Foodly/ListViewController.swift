//
//  ListViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodlyManager = FoodlyManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    /* UICollectionViewDelegate */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue" {

            if let selectedIndex = collectionView.indexPathsForSelectedItems()?.last {
                let cell = collectionView.cellForItemAtIndexPath(selectedIndex) as! RestaurantCell
                
                let restaurant = cell.restaurant
                
                let vc = segue.destinationViewController as! RestaurantViewController
                vc.restaurant = restaurant
            }
            
        }
        
    }
    
    /* UICollectionViewDatasource */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodlyManager.restaurants.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("restaurantCell", forIndexPath: indexPath) as! RestaurantCell

        cell.restaurant = foodlyManager.restaurants[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        if let randomImage = foodlyManager.randomImageFromRestaurant(cell.restaurant!) {
            cell.imageView.image = randomImage
        } else {
            cell.imageView.image = UIImage(named: "no-picture")
        }
        cell.imageView.layer.borderWidth = 0.5
        cell.imageView.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.imageView.layer.cornerRadius = 8.0
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        let screenSize = self.view.frame.size
        
        print("screenSize.width: \(screenSize.width)")

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
