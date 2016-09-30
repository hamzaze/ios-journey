//
//  AlertView.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 30/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    static func showAlert(view: UIViewController, title: String = "Napomena", message: String = "Niste odabrali kontakt") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        view.presentViewController(alertController, animated: true, completion: nil)
    }
}
