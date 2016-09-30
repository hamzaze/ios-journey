//
//  ContactTableViewController.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 18/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

protocol contactControllerDelegate {
    func fillContactForMessaging(controller: ContactTableViewController, contact: Contact)
}

class ContactTableViewController: UITableViewController, newContactControllerDelegate {
    
    // MARK: Delegate
    var delegate: contactControllerDelegate? = nil
    
    // MARK: Properties
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var contacts = [Contact]()
    var selectedRow: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load any saved contacts, otherwise load a sample data.
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        } else {
            // Load the sample data.
            loadSampleContacts()
        }
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //self.navigationItem.setRightBarButtonItems([button2, button3], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let contact = contacts[indexPath.row]
        cell.alternativeTextLabel.hidden = true
        let contactPhoneNumber = Contact.phoneInternationalPrefix + contact.phoneNumber
        if let contact = contact.name where contact != "" {
            cell.textLabel!.text = contact
            cell.alternativeTextLabel.text = contactPhoneNumber
            cell.alternativeTextLabel.hidden = false
        } else {
            cell.textlabel.text = contactPhoneNumber
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .Checkmark
            cell.backgroundColor = UIColor(red: 220, green: 226, blue: 234)
            delegate?.fillContactForMessaging(self, contact: contacts[indexPath.row])
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath){
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
            cell.backgroundColor = UIColor.clearColor()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            contacts.removeAtIndex(indexPath.row)
            saveContacts()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //Load sample contacts
    func loadSampleContacts() {
        let contact1 = Contact(name: "Fuad Odic", phoneNumber: "61774675")!
        let contact2 = Contact(name: "", phoneNumber: "65333444")!
        let contact3 = Contact(name: "Wife", phoneNumber: "62555666")!
        
        //Add sample contacts to [Contact]
        contacts += [contact1, contact2, contact3]
    }
    
    // MARK: NSCoding
    
    func saveContacts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL!.path!)
        
        if !isSuccessfulSave {
            AlertView.showAlert(self, title: "Greška", message: "Kontakt ne može biti snimljen")
        }
    }
    
    func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Contact.ArchiveURL!.path!) as? [Contact]
    }
    
    // Prepare Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addNewContact" {
            let newContact = segue.destinationViewController as! NewContactViewController
            newContact.delegate = self
        }
    }
    
    // MARK: required method to meet a protocol from NewContactViewController
    func addNewContactToContacts(controller: NewContactViewController, contact: Contact){
            // Add a new contact.
            let newIndexPath = NSIndexPath(forRow: contacts.count, inSection: 0)
            contacts.append(contact)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        
        saveContacts()
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Actions
    @IBAction func editButtonItem(sender: UIBarButtonItem) {
        self.tableView.editing = !self.tableView.editing
    }
}
