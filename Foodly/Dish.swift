//
//  Dish.swift
//  Foodly
//
//  Created by migueldiazrubio on 27/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class Dish : NSObject, NSCoding {
    
    var image : UIImage?
    var comment: String = ""
    
    init(image: UIImage?, comment: String) {
        super.init()
        self.image = image
        self.comment = comment
    }

    required init(coder decoder: NSCoder) {
        if let image = decoder.decodeObjectForKey("image") as? UIImage {
            self.image = image as UIImage
        }
        if let comment = decoder.decodeObjectForKey("comment") as? String {
            self.comment = comment as String
        }
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.image, forKey: "image")
        coder.encodeObject(self.comment, forKey: "comment")
    }
}
