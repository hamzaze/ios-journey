//
//  UserViewController.swift
//  0810_1_DesignPatterns
//
//  Created by Hamza on 12/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var suiteTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var catchPhraseTextField: UITextField!
    @IBOutlet weak var bsTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    // MARK: Action
    @IBAction func saveBtn(_ sender: UIButton) {
        guard nameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false else {
            AlertView.showAlert(view: self)
            return
        }
        
        // Get last ID from Users.shared.users
        var id: Int = 0
        if let lastUser = Users.shared.users.last {
            //Increase ID for 1, ie. autoincrement
            id = lastUser.id + 1
        }
        
        let geo = Geo(lat: latTextField.text!, lng: longTextField.text!)
        
        let address = Address(street: streetTextField.text!, suite: suiteTextField.text!, city: cityTextField.text!, zipcode: zipcodeTextField.text!, geo: geo)
        
        let company = Company(name: companyTextField.text!, catchPhrase: catchPhraseTextField.text!, bs: bsTextField.text!)
        
        let user = User(id: id, name: nameTextField.text!, username: usernameTextField.text!, email: emailTextField.text!, address: address, phone: phoneTextField.text!, website: websiteTextField.text!, company: company)
        
        Users.shared.users.insert(user, at: 0)
 
        _ = navigationController?.popViewController(animated: true)
    }
    

}

