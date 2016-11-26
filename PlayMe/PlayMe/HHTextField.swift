//
//  HHTextField.swift
//  PlayMe
//
//  Created by Hamza on 16/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

@IBDesignable class HHTextField: UITextField {

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
