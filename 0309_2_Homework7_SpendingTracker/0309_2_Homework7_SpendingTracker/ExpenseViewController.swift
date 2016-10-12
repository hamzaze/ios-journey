//
//  ExpenseViewController.swift
//  0309_2_Homework7_SpendingTracker
//
//  Created by Hamza on 04/09/16.
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
            navigationItem.title = String(expense.expenseAmount)
            nameTextField.text = String(expense.expenseAmount)
            descriptionTextView.text = expense.expenseDescription
            selectedDate.text = expense.date
        }
        
        // Enable the Save button only if the text field has a valid Expense name.
        checkValidexpenseAmount()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Disable the Save button while editing.        
        checkValidexpenseAmount()
        let text = textField.text ?? ""
        if Double(text) != nil {
            saveButton.isEnabled = !text.isEmpty
        } else {
            saveButton.isEnabled = false
            showAlert()
        }
        navigationItem.title = textField.text
    }
    
    func checkValidexpenseAmount() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Not a valid price format", message: "You\'re required to enter a valid price as an expense?", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func prepareLayoutsForFields() {
        let fieldBorderWidth: CGFloat = 1.0
        let fieldCornerRadius: CGFloat = 3.0
        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0.5, alpha: 1.0 )
        
        descriptionTextView.layer.borderColor = myColor.cgColor
        descriptionTextView.layer.borderWidth = fieldBorderWidth
        descriptionTextView.layer.cornerRadius = fieldCornerRadius
        nameTextField.layer.borderColor = myColor.cgColor
        nameTextField.layer.borderWidth = fieldBorderWidth
        nameTextField.layer.cornerRadius = fieldCornerRadius
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: currentDate)
        selectedDate.text = strDate    
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddExpenseMode = presentingViewController is UINavigationController
        if isPresentingInAddExpenseMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender {
            let name = Double(nameTextField.text ?? "0.00")
            let description = descriptionTextView.text ?? ""
            let date = selectedDate.text ?? ""
            
            // Set the Expense to be passed to ExpenseTableViewController after the unwind segue.
            expense = Expense(expenseAmount: name!, expenseDescription: description, date: date)
        }
    }
    
    // MARK: Actions
    
    @IBAction func datePickerAction(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: dateDatePicker.date)
        selectedDate.text = strDate
    }
}
