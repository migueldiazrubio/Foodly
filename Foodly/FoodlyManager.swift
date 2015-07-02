//
//  SokobanManager.swift
//  Sokoban
//
//  Created by migueldiazrubio on 4/6/15.
//  Copyright (c) 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class FoodlyManager {
    
    var restaurants : [Restaurant] = [Restaurant]()
    
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
    
    func populateRestaurants() {
        
        self.restaurants.removeAll()
        
        let restaurant = Restaurant(title: "Casa Pepe", latitude: -3.691004, longitude: 40.425419, address: "Calle Manuel Tovar 42")
        let dish = Dish(image: UIImage(named: "restaurant"), comment: "Las patatas bravas son de los mejores platos que tiene aqui. Pedirlas siempre muy picantes.")
        restaurant.dishes.append(dish)
        self.restaurants.append(restaurant)
        
    }
    
    func addRestaurant(title: String, latitude: Double, longitude: Double, address: String) {
        let restaurant = Restaurant(title: title, latitude: latitude, longitude: longitude, address: address)
        restaurants.append(restaurant)
    }
    
    func addDishToRestaurant(restaurant : Restaurant, image: UIImage, comment: String) {
        let dish = Dish(image: image, comment: comment)
        restaurant.dishes.append(dish)
    }
    
    func randomImageFromRestaurant(restaurant : Restaurant) -> UIImage? {
        
        let dishNumber : Int = restaurant.dishes.count
        if dishNumber > 0 {
            let randomDish = Int(arc4random_uniform(UInt32(dishNumber - 1)))
            return restaurant.dishes[randomDish].image
        } else {
            return nil
        }
        
    }
    
    func save() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        let dataFilePath = docsDir.stringByAppendingPathComponent("foodly.archive")
        
        if (NSKeyedArchiver.archiveRootObject(self.restaurants, toFile: dataFilePath)) {
            print("Guardado correctamente")
        } else {
            print("Error al guardar")
        }
        
    }
    
    func load() {
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        let dataFilePath = docsDir.stringByAppendingPathComponent("foodly.archive")
        
        if filemgr.fileExistsAtPath(dataFilePath) {
            let dataArray = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath) as! [Restaurant]
            self.restaurants = dataArray
            print("Recuperamos los datos de disco")
            
        } else {
            print("No hay datos grabados aún.")
        }
        
    }
    
}
