//
//  DPSegmentedControl.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 30/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class DPSegmentedControl : UISegmentedControl {
    
    // MARK: Theme colors
    // Blue
    let themeColor1 = UIColor(red: 0, green: 122, blue: 255)
    // Deep Orange
    let themeColor = UIColor(red: 255, green: 87, blue: 34)
    let cornerRadiusSize: CGFloat = 4
    let borderWithSize: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        personalizeButtons(self)
    }
    
    // MARK: Personalize buttons, (color, border, corner radius)
    func personalizeButtons(button: UISegmentedControl) {
        button.cornerRadius = cornerRadiusSize
        button.borderWidth = borderWithSize
        button.borderColor = themeColor
        button.tintColor = themeColor
    }
}
