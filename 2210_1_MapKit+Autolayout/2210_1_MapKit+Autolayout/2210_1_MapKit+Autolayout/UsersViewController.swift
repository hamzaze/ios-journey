//
//  UsersViewController.swift
//  2210_1_MapKit+Autolayout
//
//  Created by Hamza on 26/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UsersViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var mapViewMKMapView: MKMapView!
    @IBOutlet weak var tableViewTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewTableView.delegate = self
        tableViewTableView.dataSource = self
        
        // Load all users into SingleTone Users
        ServerComunication.shared.refreshUsers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UsersViewController.refresh), name: NSNotification.Name(rawValue: "UsersRefreshed"), object: nil)

    }
    
    func refresh() {
        users = Users.shared.users
        putUsersOnMap()
        tableViewTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Put Users on Map, annotations
    func putUsersOnMap() {
        for user in users {
            if let latitude = user.address?.geo?.lat, let longitude = user.address?.geo?.lng {
                let annotation = MKPointAnnotation()
                
                let coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
                annotation.coordinate = coordinate
                
                if let name = user.name {
                    annotation.title = name
                }
                var streetAndCity = ""
                if let street = user.address?.street {
                    streetAndCity += street
                }
                if let city = user.address?.city {
                    streetAndCity += ", " + city
                }
                annotation.subtitle = streetAndCity
                mapViewMKMapView.addAnnotation(annotation)
            }
        }
        if let firstUser = users.first {
            showUsersLocation(user: firstUser)
        }
    }
    
    //Show Users location
    func showUsersLocation(user: User){
        if let latitude = user.address?.geo?.lat, let longitude = user.address?.geo?.lng {
            print(latitude + " " + longitude)
            let span = MKCoordinateSpanMake(1, 1)
            let coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
            
            let mapRegion = MKCoordinateRegionMake(coordinate, span)
            mapViewMKMapView.setRegion(mapRegion, animated: true)
        }
    }
    
    // MARK: Action
    //Refresh using button at the right top
    @IBAction func sendRequestForUsers(_ sender: UIBarButtonItem) {
        ServerComunication.shared.refreshUsers()
    }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        let user = users[indexPath.row]
        showUsersLocation(user: user)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let user = users[indexPath.row]

        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = (user.address?.street)! + ", " + (user.address?.city)!

        return cell
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        annotationView.canShowCallout = true
        annotationView.pinTintColor = UIColor.blue
        return annotationView
    }
}
