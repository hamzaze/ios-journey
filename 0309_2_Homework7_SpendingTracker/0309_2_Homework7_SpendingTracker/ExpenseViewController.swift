//
//  ExpenseViewController.swift
//  2708_1_Homework6_FoodTrackerTableView
//
//  Created by Hamza on 28/08/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    
    var expense: Expense?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input trough delegate callbacks.
        nameTextField.delegate = self
        
        prepareLayoutsForFields()
        // Set up views if editing an existing Expense.
        if let expense = expense {
            navigationItem.title = String(expense.expenseName)
            nameTextField.text = String(expense.expenseName)
            descriptionTextView.text = expense.expenseDescription
            selectedDate.text = expense.date
        }
        
        // Enable the Save button only if the text field has a valid Expense name.
        checkValidExpenseName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Disable the Save button while editing.        
        checkValidExpenseName()
        let text = textField.text ?? ""
        if Double(text) != nil {
            saveButton.enabled = !text.isEmpty
        } else {
            saveButton.enabled = false
            showAlert()
        }
        navigationItem.title = textField.text
    }
    
    func checkValidExpenseName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Not a valid price format", message: "You\'re required to enter a valid price as an expense?", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func prepareLayoutsForFields() {
        let fieldBorderWidth: CGFloat = 1.0
        let fieldCornerRadius: CGFloat = 3.0
        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0.5, alpha: 1.0 )
        
        descriptionTextView.layer.borderColor = myColor.CGColor
        descriptionTextView.layer.borderWidth = fieldBorderWidth
        descriptionTextView.layer.cornerRadius = fieldCornerRadius
        nameTextField.layer.borderColor = myColor.CGColor
        nameTextField.layer.borderWidth = fieldBorderWidth
        nameTextField.layer.cornerRadius = fieldCornerRadius
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(currentDate)
        selectedDate.text = strDate    
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddExpenseMode = presentingViewController is UINavigationController
        if isPresentingInAddExpenseMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = Double(nameTextField.text ?? "0.00")
            let description = descriptionTextView.text ?? ""
            let date = selectedDate.text ?? ""
            
            // Set the Expense to be passed to ExpenseTableViewController after the unwind segue.
            expense = Expense(expenseName: name!, expenseDescription: description, date: date)
        }
    }
    
    // MARK: Actions
    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(dateDatePicker.date)
        selectedDate.text = strDate
    }
}