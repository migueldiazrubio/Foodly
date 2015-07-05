//
//  ViewImageViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 2/7/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController {
    
    var dish : Dish?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = dish?.comment
        self.imageView.image = UIImage(data: (dish?.image)!)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
    }

}
