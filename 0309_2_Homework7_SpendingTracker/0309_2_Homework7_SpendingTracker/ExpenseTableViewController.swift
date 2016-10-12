//
//  ExpenseTableViewController.swift
//  0309_2_Homework7_SpendingTracker
//
//  Created by Hamza on 04/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class ExpenseTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var Expenses = [Expense]()
    var expensesDaily: [String:[Int:[Expense]]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved Expenses, otherwise load sample date.
        if let savedExpenses = loadExpenses() {
            Expenses += savedExpenses
        } else {
            // Load the sample data.
            print("Load the sample data");
            loadSampleExpenses()
        }
    }
    
    func loadSampleExpenses() {
        let Expense1 = Expense(expenseAmount: 20.5, expenseDescription: "Food and School", date: "05-09-2016 18:32")!
        
        let Expense2 = Expense(expenseAmount: 102.00, expenseDescription: "Bills for Mobile/Internet, food, transportation", date: "05-09-2016 21:20")!
        
        let Expense3 = Expense(expenseAmount: 16.00, expenseDescription: "Bills for Mobile/Internet, food, transportation", date: "06-09-2016 10:20")!
        
        Expenses += [Expense1, Expense2, Expense3]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return expensesDaily.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExpenseTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExpenseTableViewCell
        
        // Fetches the appropriate Expense for the data source layout.
        let Expense = Expenses[(indexPath as NSIndexPath).row]
        
        let dateFullString = stringToDateString(Expense.date)

        cell.nameLabel.text = String(Expense.expenseAmount) + " " + Expense.currencySign
        cell.dateLabel.text = dateFullString
        cell.descriptionLabel.numberOfLines = 0
        [cell.descriptionLabel .sizeToFit()]

        cell.descriptionLabel.text = Expense.expenseDescription

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Expenses.remove(at: (indexPath as NSIndexPath).row)
            saveExpenses()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let ExpenseDetailViewController = segue.destination as! ExpenseViewController
            // Get the cell that generated this segue
            if let selectedExpenseCell = sender as? ExpenseTableViewCell {
                let indexPath = tableView.indexPath(for: selectedExpenseCell)!
                let selectedExpense = Expenses[(indexPath as NSIndexPath).row]
                ExpenseDetailViewController.expense = selectedExpense
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new Expense")
        }
    }
    
    
    
    @IBAction func unwindToExpenseList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ExpenseViewController, let Expense = sourceViewController.expense {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Expense
                Expenses[(selectedIndexPath as NSIndexPath).row] = Expense
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new Expense.
                let newIndexPath = IndexPath(row: Expenses.count, section: 0)
                Expenses.append(Expense)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            // Save the Expenses.
            saveExpenses()
        }
    }
    
    // MARK: NSCoding
    
    func saveExpenses() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Expenses, toFile: Expense.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save Expenses...")
        }
    }
    
    func loadExpenses() -> [Expense]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Expense.ArchiveURL.path!) as? [Expense]
    }
    
    func stringToDateString(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: string)
        let newDateString = dateFormatter1.string(from: date!)
        return newDateString
    }

}
