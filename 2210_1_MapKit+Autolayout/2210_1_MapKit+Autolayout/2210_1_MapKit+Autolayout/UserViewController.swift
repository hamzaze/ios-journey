//
//  UserViewController.swift
//  2210_1_MapKit+Autolayout
//
//  Created by Hamza on 28/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit
import MapKit

class UserViewController: UIViewController {
    
    var user: User?
    
    // MARK: Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    
    
    let userIcons = ["maletemp", "femaletemp"]

    override func viewDidLoad() {
        super.viewDidLoad()
        displayUser(user!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // Odd behaviour for UILabel and Optional, nil
    func displayUser(_ user: User) {
        // Display a random M/F avatars
        let random = Int(arc4random_uniform(2))
        userIconImageView.image = UIImage(named: userIcons[random])
        
        var streetAndCity = ""
        if let name = user.name {
            nameLabel.text = name
            nameTitleLabel.text = name
        }
        if let username = user.username {
            usernameLabel.text = username
        }
        if let email = user.email {
            emailLabel.text = email
        }
        if let address = user.address {
            if let street = address.street {
                streetAndCity += street
            }
            if let city = address.city {
                streetAndCity += ", \(city)"
            }
            addressLabel.text = streetAndCity
        }
        if let phoneNumber = user.phone {
            phoneLabel.text = phoneNumber
        }
        if let website = user.website {
            websiteLabel.text = website
        }
        if let company = user.company {
            if let name = company.name {
                companyLabel.text = name
            }
        }
    }
    

}
