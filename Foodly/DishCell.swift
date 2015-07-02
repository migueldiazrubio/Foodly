//
//  DishCell.swift
//  Foodly
//
//  Created by migueldiazrubio on 27/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {

    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    var dish : Dish? {
        willSet(newValue) {
            self.dishImage.image = newValue?.image
            self.commentLabel.text = newValue?.comment
        }
    }

}
