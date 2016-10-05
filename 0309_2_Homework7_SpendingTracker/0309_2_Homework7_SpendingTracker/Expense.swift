//
//  Expense.swift
//  0309_2_Homework7_SpendingTracker
//
//  Created by Hamza on 04/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class Expense: NSObject, NSCoding {
    
    // MARK: Properties
    
    var expenseAmount: Double
    var expenseDescription: String?
    var date: String
    
    let currencySign = "KM"
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("expenses")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "expenseDescription"
        static let dateKey = "date"
    }
    
    // MARK: Initialization
    
    init?(expenseAmount: Double, expenseDescription: String?, date: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if expenseAmount == 0.00 {
            return nil
        }
        // Initialize stored properties.
        self.expenseAmount = expenseAmount
        self.expenseDescription = expenseDescription
        self.date = date
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(expenseAmount, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(expenseDescription, forKey: PropertyKey.descriptionKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! Double
        let expenseDescription = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! String
        
        // Must call designated initializer.
        self.init(expenseAmount: name, expenseDescription: expenseDescription, date: date)
    }
}