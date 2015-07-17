//
//  RestaurantCell.swift
//  Foodly
//
//  Created by migueldiazrubio on 22/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var editing : Bool = false {
        didSet {
            titleLabel.hidden = editing
            selectedImage.hidden = !editing
        }
    }
    
    override var selected: Bool {
        didSet {
            if editing {
                selectedImage.image = UIImage(named: selected ? "Checked" : "Unchecked")
            }
        }
    }
    
    var restaurant : Restaurant? {
        willSet(newValue) {
            self.titleLabel.text = newValue?.title
        }
    }
    
}
