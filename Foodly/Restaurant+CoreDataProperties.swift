//
//  Restaurant+CoreDataProperties.swift
//  Foodly
//
//  Created by migueldiazrubio on 9/7/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var address: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var title: String?
    @NSManaged var dishes: NSSet?

}
