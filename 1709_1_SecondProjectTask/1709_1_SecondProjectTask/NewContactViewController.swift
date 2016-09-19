//
//  NewContactViewController.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 18/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

protocol newContactControllerDelegate {
    func addNewContactToContacts(controller: NewContactViewController, contact: Contact)
}

class NewContactViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Delegate
    var delegate: newContactControllerDelegate? = nil

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var addNewContactButton: UIButton!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultSegmentedControlsState()
        // Handle the text field's user input trough delegate callbacks.
        phoneTextField.delegate = self

    }
    
    func setupDefaultSegmentedControlsState() {
        addNewContactButton.cornerRadius = 4
        addNewContactButton.borderWidth = 1
        addNewContactButton.borderColor = Contact.themeColor
        addNewContactButton.tintColor = Contact.themeColor
        
        nameTextField.cornerRadius = 4
        nameTextField.borderWidth = 1
        nameTextField.borderColor = Contact.themeColor
        nameTextField.tintColor = Contact.themeColor
        
        phoneTextField.cornerRadius = 4
        phoneTextField.borderWidth = 1
        phoneTextField.borderColor = Contact.themeColor
        phoneTextField.tintColor = Contact.themeColor

    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Disable the Save button while editing.
        let isPhoneNumber = checkValidPhoneNumber()
        if !isPhoneNumber {
            showAlert()
        }
    }
    
    func checkValidPhoneNumber() -> Bool{
        // Disable the Save button if the text field is empty.
        let text = phoneTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        return saveButton.enabled
    }
    
    //Alert function
    func showAlert() {
        let alertController = UIAlertController(title: "Greška", message: "Broj telefona je obavezan", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: Actions
    @IBAction func addNewContactFromMenu(sender: UIBarButtonItem) {
        addNewContact(sender)
    }
    
    @IBAction func addNewContact(sender: AnyObject) {
        let isPhoneNumber = checkValidPhoneNumber()
        if !isPhoneNumber {
            showAlert()
            return
        } else {
            let name = nameTextField.text ?? ""
            let phone = phoneTextField.text
            
            // Set the contact to be passed to ContactTableViewController after the unwind segue.
            contact = Contact(name: name, phoneNumber: phone!)
            delegate?.addNewContactToContacts(self, contact: contact!)
        }
    }
    
    
}
