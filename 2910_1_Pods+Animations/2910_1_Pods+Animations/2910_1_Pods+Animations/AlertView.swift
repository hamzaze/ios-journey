//
//  AlertView.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 30/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    static func showAlert(_ view: UIViewController, title: String = "Information", message: String = "All fields are required") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
