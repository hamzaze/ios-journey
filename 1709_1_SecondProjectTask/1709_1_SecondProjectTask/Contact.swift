//
//  Contact.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 18/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

//class Contact: NSObject, NSCoding {
class Contact: NSObject {
    
    // MARK: Properties
    var name: String?
    var phoneNumber: String
    // Phone number prefix for Bosnia and Herzegovina, ie. +387
    static let phoneInternationalPrefix = "+387"
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("contacts1")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let phoneNumberKey = "phoneNumber"
    }

    //initialization
    init?(name: String?, phoneNumber: String) {
        if phoneNumber.isEmpty {
            return nil
        }
        self.name = name
        self.phoneNumber = phoneNumber
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(phoneNumber, forKey: PropertyKey.phoneNumberKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let phone = aDecoder.decodeObjectForKey(PropertyKey.phoneNumberKey) as! String
        // Must call designated initializer.
        self.init(name: name, phoneNumber: phone)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
}
