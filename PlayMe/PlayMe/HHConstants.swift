//
//  HHConstants.swift
//  PlayMe
//
//  Created by Hamza on 16/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

struct HHConstants {
    struct FontColors {
         static let colorWhite = UIColor(red: 255, green: 255, blue: 255)
         static let colorBlack = UIColor(red: 0, green: 0, blue: 0)
         static let colorGray = UIColor(red: 127, green: 127, blue: 127)
    }
    
    struct ViewHeights {
        static let navigationBarSize = CGSize(width: UIScreen.main.bounds.width, height: 63)
        static let tabBarSize = CGSize(width: UIScreen.main.bounds.width, height: 64)
    }
    
    static func wrapDefaultNavigationController() {
        UINavigationBar.appearance().barTintColor = FontColors.colorWhite
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName:FontColors.colorGray,
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 20)!
        ]
        UIToolbar.appearance().barTintColor = FontColors.colorWhite
        UIToolbar.appearance().tintColor = FontColors.colorGray
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

extension UINavigationBar {
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize = HHConstants.ViewHeights.navigationBarSize
        return newSize
    }
}

extension UIToolbar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize = HHConstants.ViewHeights.tabBarSize
        return newSize
    }
}
