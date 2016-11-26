//
//  AlertView.swift
//  1709_1_SecondProjectTask
//
//  Created by Hamza on 30/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    //Allow Camera
    static func showAlertAllowCamera(_ view: UIViewController, title: String = "Allow camera access?", message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Allow", style: .default, handler: {(alert: UIAlertAction!) in AlertView.showAlertAllowMicrophone(view)})
        let anotherAction = UIAlertAction(title: "Decline", style: .default, handler: nil)
        alertController.addAction(anotherAction)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    //Allow Microphone
    static func showAlertAllowMicrophone(_ view: UIViewController, title: String = "Allow microphone access?", message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Allow", style: .default, handler: {(alert: UIAlertAction!) in AlertView.showAlertAllowLocation(view)})
        let anotherAction = UIAlertAction(title: "Decline", style: .default, handler: nil)
        alertController.addAction(anotherAction)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    //Allow Location
    static func showAlertAllowLocation(_ view: UIViewController, title: String = "Allow location track?", message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Allow", style: .default, handler: {(alert: UIAlertAction!) in AlertView.showAlertAllowNotifications(view)})
        let anotherAction = UIAlertAction(title: "Decline", style: .default, handler: nil)
        alertController.addAction(anotherAction)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    //Allow Notifications
    static func showAlertAllowNotifications(_ view: UIViewController, title: String = "Allow notifications?", message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Allow", style: .default, handler: {(action) -> Void in
            let recordViewController = view.storyboard?.instantiateViewController(withIdentifier: "recordVideo") as! RecordVideoViewController
            view.navigationController?.pushViewController(recordViewController, animated: true)

            })
        let anotherAction = UIAlertAction(title: "Decline", style: .default, handler: nil)
        alertController.addAction(anotherAction)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
