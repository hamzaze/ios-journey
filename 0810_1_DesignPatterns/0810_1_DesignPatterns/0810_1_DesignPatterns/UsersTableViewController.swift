//
//  UsersTableViewController.swift
//  0810_1_DesignPatterns
//
//  Created by Hamza on 12/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load all users into SingleTone Users
       ServerComunication.shared.refreshUsers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UsersTableViewController.refresh), name: NSNotification.Name(rawValue: "UsersRefreshed"), object: nil)
    }
    
    func refresh() {
        users = Users.shared.users
        tableView.reloadData()
    }
    
    // MARK: Action
    //Refresh using button at the right top
    @IBAction func sendRequestForUsers(_ sender: UIBarButtonItem) {
        ServerComunication.shared.refreshUsers()
    }
}

extension UsersTableViewController {
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
}
