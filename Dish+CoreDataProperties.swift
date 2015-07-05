//
//  Dish+CoreDataProperties.swift
//  Foodly
//
//  Created by migueldiazrubio on 5/7/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Dish {

    @NSManaged var comment: String?
    @NSManaged var image: NSData?
    @NSManaged var restaurant: Restaurant?

}
