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
    
    @IBOutlet weak var mobileOperatorSegmentedControl: DPSegmentedControl!
    @IBOutlet weak var creditSegmentedControl: DPSegmentedControl!
    @IBOutlet weak var chooseContactButton: DPButton!
    @IBOutlet weak var chargeAccount: DPButton!
    
    
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
        
        // Set up SegmentedControl for credit charges, by default it is MTel
        setupCreditChargeSegmentedControl(creditSegmentedControl, creditCharges: chargesMTel)
    }
    
    // MARK: Actions
    
    // Get selected mobile operator and toggle creditCharge segment controls
    @IBAction func chooseOperator(sender: UISegmentedControl) {
        mobileOperater = sender.selectedSegmentIndex
        
        //reset all credit charges to default
        creditSegmentedControl.selectedSegmentIndex = 0
        
        switch sender.selectedSegmentIndex {
            case 0:
                setupCreditChargeSegmentedControl(creditSegmentedControl, creditCharges: chargesMTel)
                mobileCharge = creditSegmentedControl.selectedSegmentIndex
            case 1:
                setupCreditChargeSegmentedControl(creditSegmentedControl, creditCharges: chargesBHTelecom)
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
    
    // MARK: Generate M-Commerce message
    @IBAction func generateMCommerceMessage(sender: UIButton) {
        guard selectedContact != nil else {
            AlertView.showAlert(self)
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
        AlertView.showAlert(self, title: "SMS Poruka", message: messageBody + " for recipient " + messageRecipient)
        
        
        // Simulator is not able to send SMS so we see this message instead
        if !canSendText() {
            AlertView.showAlert(self, title: "Greška", message: "Uređaj ne moze poslati SMS")
        } else {
            let messageVC = MFMessageComposeViewController()
        
            messageVC.body = messageBody;
            messageVC.recipients = [messageRecipient]
            messageVC.messageComposeDelegate = self;
        
            self.presentViewController(messageVC, animated: true, completion: nil)
        }
    }
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectContact" {
            let selectedNewContact = segue.destinationViewController as! ContactTableViewController
            selectedNewContact.delegate = self
        }
    }
    
    // MARK: required method to meet a protocol 
    func fillContactForMessaging(controller: ContactTableViewController, contact: Contact) {
        selectedContact = contact
        var tempNameOrPhone: String?
        let contactPhoneNumber = Contact.phoneInternationalPrefix + contact.phoneNumber
        if let contact = contact.name where contact != "" {
            tempNameOrPhone = contact
        } else {
            tempNameOrPhone = contactPhoneNumber
        }

        chooseContactButton.setTitle(tempNameOrPhone, forState: .Normal)
        chooseContactButton.contentHorizontalAlignment = .Center
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Set up UISegmentedControl default values
    func setupCreditChargeSegmentedControl(segmentedControl: UISegmentedControl, creditCharges: [Int]) {
        segmentedControl.removeAllSegments()
        for i in creditCharges {
            let currentIndex = creditCharges.indexOf(i)
            segmentedControl.insertSegmentWithTitle(String(i) + " KM", atIndex: currentIndex!, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 1
    }

}

