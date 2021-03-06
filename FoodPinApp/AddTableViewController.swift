//
//  AddTableViewController.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/9.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextFiedl: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var restaurant: Restaurant!
    
    var isVisited: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        
        // coreData
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = nameTextFiedl.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.image = UIImagePNGRepresentation(imageView.image!)
            restaurant.isVisited = isVisited
            
            do {
                try managedObjectContext.save()
            }
            catch let error {
                print("insert error: \(error)")
                    
            }
            
            
            
        }
        
        var errorField = ""
        if nameTextFiedl.text == "" {
            errorField = "name"
        }
        else if typeTextField.text == "" {
            errorField = "type"
        }
        else if locationTextField.text == "" {
            errorField = "location"
        }
        if !errorField.isEmpty {
            let alertVC =  UIAlertController(title: "Oops", message: "We cannot proceed ad you forget to fill in the restaurant \(errorField) . All fields are mandatory", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertVC, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func isVisitedAction(btn: UIButton) {
        if btn == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.grayColor()
        }
        else if btn == noButton {
            isVisited = false
            noButton.backgroundColor = UIColor.redColor()
            yesButton.backgroundColor = UIColor.grayColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0  {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self //遵循协议
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
}
