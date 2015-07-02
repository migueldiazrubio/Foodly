//
//  Restaurant.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class Restaurant : NSObject, NSCoding {
    
    var title : String = ""
    var latitude : Double = 0
    var longitude : Double = 0
    var address : String = ""
    var dishes : [Dish] = [Dish]()
    
    init(title: String, latitude: Double, longitude: Double, address: String) {
        super.init()
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    required init(coder decoder: NSCoder) {
        if let title = decoder.decodeObjectForKey("title") as? String {
            self.title = title as String
        }
        self.latitude = decoder.decodeDoubleForKey("latitude")
        self.longitude = decoder.decodeDoubleForKey("longitude")
        if let address = decoder.decodeObjectForKey("address") as? String {
            self.address = address as String
        }
        if let dishes = decoder.decodeObjectForKey("dishes") as? [Dish] {
            self.dishes = dishes as [Dish]
        }
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeDouble(self.latitude, forKey: "latitude")
        coder.encodeDouble(self.longitude, forKey: "longitude")
        coder.encodeObject(self.address, forKey: "address")
        coder.encodeObject(self.dishes, forKey: "dishes")
        
    }

}
