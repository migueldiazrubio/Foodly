//
//  SokobanManager.swift
//  Sokoban
//
//  Created by migueldiazrubio on 4/6/15.
//  Copyright (c) 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit
import CoreData

class FoodlyManager {
    
    class var sharedInstance: FoodlyManager {
        struct Static {
            static var instance: FoodlyManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = FoodlyManager()
        }
        
        return Static.instance!
    }
    
    func restaurants() -> Array<Restaurant>? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        // Retrieve all restaurants
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")

        do {
        
            if let restaurants = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [Restaurant] {
                
                return restaurants
            }
        
        } catch {
            print("Error while loading restaurants")
        }
        
        return nil
    }
    
    func addRestaurant(title: String, latitude: Double, longitude: Double, address: String) -> Restaurant {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: appDelegate.managedObjectContext) as! Restaurant
        
        restaurant.title = title
        restaurant.latitude = latitude
        restaurant.longitude = longitude
        restaurant.address = address
        return restaurant
    
    }
    
    func addDishToRestaurant(restaurant : Restaurant, image: UIImage, comment: String) -> Dish {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let dish = NSEntityDescription.insertNewObjectForEntityForName("Dish", inManagedObjectContext: appDelegate.managedObjectContext) as! Dish
        
        dish.image = UIImagePNGRepresentation(image)
        dish.comment = comment
        dish.restaurant = restaurant

        return dish
    }
    
//    func randomImageFromRestaurant(restaurant : Restaurant) -> UIImage? {
//        
//        let dishNumber : Int = restaurant.dishes!.count
//        if dishNumber > 0 {
//            let randomDishNumber = Int(arc4random_uniform(UInt32(dishNumber - 1)))
//            let dish = restaurant.dishes[randomDishNumber] as! Dish
//            return UIImage(data: dish.image)
//        } else {
//            return nil
//        }
//        
//    }
    
    func save() {

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveContext()
    }
    
}
