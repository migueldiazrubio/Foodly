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

    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func restaurants() -> Array<Restaurant>? {
        
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
        
        let restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: appDelegate.managedObjectContext) as! Restaurant
        
        restaurant.title = title
        restaurant.latitude = latitude
        restaurant.longitude = longitude
        restaurant.address = address
        
        save()

        return restaurant
    
    }
    
    func addDishToRestaurant(restaurant : Restaurant, image: UIImage, comment: String) -> Dish {
        
        let dish = NSEntityDescription.insertNewObjectForEntityForName("Dish", inManagedObjectContext: appDelegate.managedObjectContext) as! Dish
        
        dish.image = UIImagePNGRepresentation(image)
        dish.comment = comment
        dish.restaurant = restaurant
        
        save()
        
        return dish
    }
    
    func deleteRestaurant (restaurant: Restaurant) {
        appDelegate.managedObjectContext.deleteObject(restaurant)
        save()
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
}
