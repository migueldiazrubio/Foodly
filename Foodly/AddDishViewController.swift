//
//  AddDishViewController.swift
//  Foodly
//
//  Created by migueldiazrubio on 27/6/15.
//  Copyright © 2015 Miguel Díaz Rubio. All rights reserved.
//

import UIKit

class AddDishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var foodlyManager = FoodlyManager.sharedInstance
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var restaurant : Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Añadimos el gesto para hacer la foto
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("choosePhotoFromCameraOrLibrary:"))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    @IBAction func save(sender: AnyObject) {
        
        if textField.text != "" && imageView.image != nil {
            foodlyManager.addDishToRestaurant(restaurant!, image: imageView.image!, comment: textField.text!)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Debe introducir un nombre para el plato", preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* Camera methods */
    func choosePhotoFromCameraOrLibrary(gesture: UITapGestureRecognizer) {

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            showActionSheet()
        } else {
            capturePhotoFromCamera(false)
        }
    
    }
    
    func showActionSheet() {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Elige una opción", preferredStyle: .ActionSheet)
        
        // 2
        let takePhotoAction = UIAlertAction(title: "Hacer foto", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.capturePhotoFromCamera(true)
        })
        let chooseFromRollAction = UIAlertAction(title: "Carrete", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.capturePhotoFromCamera(false)
        })
        
        let cancelAction = UIAlertAction(title: "Carrete", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // 4
        optionMenu.addAction(takePhotoAction)
        optionMenu.addAction(chooseFromRollAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func capturePhotoFromCamera(camera: Bool) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        if camera {
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = imageThumbnail(image)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageThumbnail(imageObj:UIImage)-> UIImage {
        
        let newSize : CGSize = CGSizeMake(250.0, 250.0)
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(newSize, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: newSize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let lowQualityData = UIImageJPEGRepresentation(scaledImage, 0.3)
        let lowQualityImage = UIImage(data: lowQualityData!)
        
        return lowQualityImage!
    }
    
}
