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
    @IBOutlet weak var nameTextField: DPTextField!
    @IBOutlet weak var phoneTextField: DPTextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var addNewContactButton: DPButton!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input trough delegate callbacks.
        phoneTextField.delegate = self
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
            AlertView.showAlert(self, title: "Greška", message: "Broj telefona je obavezan")
        }
    }
    
    func checkValidPhoneNumber() -> Bool{
        // Disable the Save button if the text field is empty.
        let text = phoneTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        return saveButton.enabled
    }
    
    // MARK: Actions
    @IBAction func addNewContactFromMenu(sender: UIBarButtonItem) {
        addNewContact(sender)
    }
    
    @IBAction func addNewContact(sender: AnyObject) {
        let isPhoneNumber = checkValidPhoneNumber()
        if !isPhoneNumber {
            AlertView.showAlert(self, title: "Greška", message: "Broj telefona je obavezan")
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
