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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
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
        let Expense1 = Expense(expenseName: 20.5, expenseDescription: "Food and School", date: "05-09-2016 18:32")!
        
        let Expense2 = Expense(expenseName: 102.00, expenseDescription: "Bills for Mobile/Internet, food, transportation", date: "05-09-2016 21:20")!
        
        let Expense3 = Expense(expenseName: 16.00, expenseDescription: "Bills for Mobile/Internet, food, transportation", date: "06-09-2016 10:20")!
        
        Expenses += [Expense1, Expense2, Expense3]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Expenses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExpenseTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseTableViewCell
        
        // Fetches the appropriate Expense for the data source layout.
        let Expense = Expenses[indexPath.row]
        
        let dateFullString = stringToDateString(Expense.date)

        cell.nameLabel.text = String(Expense.expenseName) + " " + Expense.currencySign
        cell.dateLabel.text = dateFullString
        cell.descriptionLabel.numberOfLines = 0
        [cell.descriptionLabel .sizeToFit()]

        cell.descriptionLabel.text = Expense.expenseDescription

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            Expenses.removeAtIndex(indexPath.row)
            saveExpenses()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let ExpenseDetailViewController = segue.destinationViewController as! ExpenseViewController
            // Get the cell that generated this segue
            if let selectedExpenseCell = sender as? ExpenseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedExpenseCell)!
                let selectedExpense = Expenses[indexPath.row]
                ExpenseDetailViewController.expense = selectedExpense
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new Expense")
        }
    }
    
    
    
    @IBAction func unwindToExpenseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ExpenseViewController, Expense = sourceViewController.expense {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Expense
                Expenses[selectedIndexPath.row] = Expense
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new Expense.
                let newIndexPath = NSIndexPath(forRow: Expenses.count, inSection: 0)
                Expenses.append(Expense)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
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
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURL.path!) as? [Expense]
    }
    
    func stringToDateString(string: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateFormatter1 = NSDateFormatter()
        dateFormatter1.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.dateFromString(string)
        let newDateString = dateFormatter1.stringFromDate(date!)
        return newDateString
    }

}
