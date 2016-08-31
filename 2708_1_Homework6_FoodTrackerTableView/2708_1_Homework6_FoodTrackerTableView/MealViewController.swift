//
//  MealViewController.swift
//  2708_1_Homework6_FoodTrackerTableView
//
//  Created by Hamza on 28/08/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input trough delegate callbacks.
        nameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidMealName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Disable the Save button while editing.        
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerControler = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerControler.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image
        imagePickerControler.delegate = self
        
        presentViewController(imagePickerControler, animated: true, completion: nil)
    }
}

