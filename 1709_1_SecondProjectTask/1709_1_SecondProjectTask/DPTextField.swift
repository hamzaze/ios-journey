//
//  DPTextField.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 30/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class DPTextField : UITextField {
    
    // MARK: Theme colors
    // Blue
    let themeColor1 = UIColor(red: 0, green: 122, blue: 255)
    // Deep Orange
    let themeColor = UIColor(red: 255, green: 87, blue: 34)
    let cornerRadiusSize: CGFloat = 4
    let borderWithSize: CGFloat = 1

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        personalizeTextFields(self)
    }
    
    // MARK: Personalize text fields, (color, border, corner radius)
    func personalizeTextFields(textField: UITextField) {
        textField.cornerRadius = cornerRadiusSize
        textField.borderWidth = borderWithSize
        textField.borderColor = themeColor
        textField.tintColor = themeColor
    }
}
