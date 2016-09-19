//
//  MainViewController.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 18/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit
import MessageUI

class MainViewController: UIViewController, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate, contactControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var mobileOperatorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var creditMTelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var creditBHTelecomSegmentedControl: UISegmentedControl!
    @IBOutlet weak var chooseContactButton: UIButton!
    @IBOutlet weak var chargeAccount: UIButton!
    
    
    var contact: Contact?
    var mobileOperater = 0
    var mobileCharge = 0
    
    // Constants for SMS M-Commerce receivers MTel or BHTelecom
    let receiverMTelNumber = "0651110"
    let receiverBHTelecomNumber = "0611171"
    let prefixForMTelMessage = "D"
    let prefixForBHTelecomMessage = ""
    let chargesMTel = [2,3,4,5,10]
    let chargesBHTelecom = [1,2,5,10,20]
    
    // Selected contact
    var selectedContact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultSegmentedControlsState()
    }
    
    // Mark: Actions
    
    func setupDefaultSegmentedControlsState() {
        //Let's custom style, colorize entire App
        
        // Set Navigation bar tint / background color
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.barTintColor = Contact.themeColor
        
        chooseContactButton.cornerRadius = 4
        chooseContactButton.borderWidth = 1
        chooseContactButton.borderColor = Contact.themeColor
        chooseContactButton.tintColor = Contact.themeColor
        
        chargeAccount.cornerRadius = 4
        chargeAccount.borderWidth = 1
        chargeAccount.borderColor = Contact.themeColor
        chargeAccount.tintColor = Contact.themeColor
        
        mobileOperatorSegmentedControl.cornerRadius = 4
        mobileOperatorSegmentedControl.borderWidth = 1
        mobileOperatorSegmentedControl.borderColor = Contact.themeColor
        mobileOperatorSegmentedControl.tintColor = Contact.themeColor
        
        creditMTelSegmentedControl.cornerRadius = 4
        creditMTelSegmentedControl.borderWidth = 1
        creditMTelSegmentedControl.borderColor = Contact.themeColor
        creditMTelSegmentedControl.tintColor = Contact.themeColor
        
        creditBHTelecomSegmentedControl.cornerRadius = 4
        creditBHTelecomSegmentedControl.borderWidth = 1
        creditBHTelecomSegmentedControl.borderColor = Contact.themeColor
        creditBHTelecomSegmentedControl.tintColor = Contact.themeColor
         
        creditMTelSegmentedControl.hidden = false
        creditBHTelecomSegmentedControl.hidden = true
    }
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Get selected mobile operator and toggle creditCharge segment controls
    @IBAction func chooseOperator(sender: UISegmentedControl) {
        mobileOperater = sender.selectedSegmentIndex
        
        //reset all credit charges to default
        creditMTelSegmentedControl.selectedSegmentIndex = 0
        creditBHTelecomSegmentedControl.selectedSegmentIndex = 1
        
        
        switch sender.selectedSegmentIndex {
            case 0:
                creditMTelSegmentedControl.hidden = false
                creditBHTelecomSegmentedControl.hidden = true
                mobileCharge = creditMTelSegmentedControl.selectedSegmentIndex
            case 1:
                creditMTelSegmentedControl.hidden = true
                creditBHTelecomSegmentedControl.hidden = false
                mobileCharge = creditBHTelecomSegmentedControl.selectedSegmentIndex
            default:
                break
        }
        
    }
    
    //Get selected mobile charge amount for MTel
    @IBAction func chooseMtelCharge(sender: UISegmentedControl) {
        mobileCharge = sender.selectedSegmentIndex
    }
    
    //Get selected mobile charge amount for BHTelecom
    @IBAction func chooseBHTelecomCharge(sender: UISegmentedControl) {
        mobileCharge = sender.selectedSegmentIndex
    }
    
    //Generate M-Commerce message
    @IBAction func generateMCommerceMessage(sender: UIButton) {
        guard selectedContact != nil else {
            showAlert()
            return;
        }
        var messageBody = ""
        let messageRecipient = Contact.phoneInternationalPrefix + (selectedContact?.phoneNumber)!
        switch mobileOperater {
            case 0:
                messageBody += prefixForMTelMessage
                messageBody += String(chargesMTel[mobileCharge])
                messageBody += " " + receiverMTelNumber
            case 1:
                messageBody += String(chargesBHTelecom[mobileCharge])
                messageBody += " " + receiverBHTelecomNumber
            default:
            
            break;
        }
        
        // Checking point to confirm it will work well on devices with SIM card
        print(messageBody + " for recipient " + messageRecipient)
        
        
        // Simulator is not able to send SMS so we see this message instead
        if !canSendText() {
            print("Uredjaj ne moze poslati SMS")
        } else {
        
            let messageVC = MFMessageComposeViewController()
        
            messageVC.body = messageBody;
            messageVC.recipients = [messageRecipient]
            messageVC.messageComposeDelegate = self;
        
            self.presentViewController(messageVC, animated: true, completion: nil)
        }
    }
    
    //Alert function
    func showAlert() {
        let alertController = UIAlertController(title: "Napomena", message: "Niste odabrali kontakt", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectContact" {
            let selectedContact = segue.destinationViewController as! ContactTableViewController
            selectedContact.delegate = self
        }
    }
    
    // MARK: required method to meet a protocol 
    func fillContactForMessaging(controller: ContactTableViewController, contact: Contact) {
        selectedContact = contact
        var tempNameOrPhone: String?
        let contactPhoneNumber = Contact.phoneInternationalPrefix + selectedContact!.phoneNumber
        if let contactName = selectedContact!.name where selectedContact!.name != "" {
            tempNameOrPhone = contactName
        } else {
            tempNameOrPhone = contactPhoneNumber
        }

        chooseContactButton.setTitle(tempNameOrPhone, forState: .Normal)
        chooseContactButton.contentHorizontalAlignment = .Center
        controller.navigationController?.popViewControllerAnimated(true)
    }

}

