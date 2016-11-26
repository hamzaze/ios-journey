//
//  HHLabel.swift
//  PlayMe
//
//  Created by Hamza on 16/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class HHLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = HHConstants.FontColors.colorWhite
        self.tintColor = HHConstants.FontColors.colorWhite
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
