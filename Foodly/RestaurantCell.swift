//
//  RestaurantCell.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var restaurant : Restaurant? {
        willSet(newValue) {
            self.titleLabel.text = newValue?.title
        }
    }
    
}
