//
//  RadialGradientView.swift
//  2210_1_MapKit+Autolayout
//
//  Created by Hamza on 28/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class RadialGradientView: UIView {
    let colorTop = UIColor(red: 87.0/255.0, green: 138.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [colorTop, colorBottom]
    }
}
