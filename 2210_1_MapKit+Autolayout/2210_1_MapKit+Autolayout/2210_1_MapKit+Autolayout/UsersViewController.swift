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
        mapViewMKMapView.delegate = self
        
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
        for (index, user) in users.enumerated() {
            if let address = user.address {
                if let geo = address.geo {
                    if let latitude = geo.lat, let longitude = geo.lng {
                        //Check could latitude, longitude can be casted as Double, otherwise return
                        guard let _ = Double(latitude), let _ = Double(longitude) else{
                            return
                        }
                        let coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)

                        let annotation = HHAnnotation(coordinate: coordinate)
                        
                        annotation.index = index
                        if let name = user.name {
                            annotation.title = "\(name) : \(index)"
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
            }
        }
        if let firstUser = users.first {
            showUsersLocation(user: firstUser)
        }
        
    }
    
    //Show Users location
    func showUsersLocation(user: User){
        if let address = user.address {
            if let geo = address.geo {
                if let latitude = geo.lat, let longitude = geo.lng {
                    //Check could latitude, longitude can be casted as Double, otherwise return
                    guard let _ = Double(latitude), let _ = Double(longitude) else{
                        return
                    }
                    let span = MKCoordinateSpanMake(1, 1)
                    let coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
            
                    let mapRegion = MKCoordinateRegionMake(coordinate, span)
                    self.mapViewMKMapView.setRegion(mapRegion, animated: false)                }
            }
        }
    }
    
    //Display selected user from annotation
    func displayUser(sender: UIButton) {
        let sentIndex = sender.tag
        let sentUser = users[sentIndex]
        let userView = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        userView.user = sentUser
        self.navigationController?.pushViewController(userView, animated: true)
    }
    
    // MARK: Action
    //Refresh using button at the right top
    @IBAction func sendRequestForUsers(_ sender: UIBarButtonItem) {
        ServerComunication.shared.refreshUsers()
    }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print(indexPath.row)
        let user = users[indexPath.row]
        showUsersLocation(user: user)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let user = users[indexPath.row]

        if let name = user.name {
            cell.textLabel?.text = "\(name)  : \(indexPath.row)"
        }
        
        if let address = user.address {
            var stringAddress = ""
            if let street = address.street {
                stringAddress += street
            }
            if let city = address.city{
                stringAddress += ", \(city)"
            }
            cell.detailTextLabel?.text = stringAddress
        }
        return cell
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? HHAnnotation {
            let identifier = "pin"
            var annotationView: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                annotationView = dequeuedView
            } else {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                btn.tag = annotation.index!
                btn.addTarget(self, action: #selector(UsersViewController.displayUser), for: UIControlEvents.touchUpInside)
                annotationView.rightCalloutAccessoryView = btn
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ didUpdatemapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapViewMKMapView.centerCoordinate = (userLocation.location?.coordinate)!
    }
    
    /*
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.detailDisclosure {
            if let annotation = view.annotation as? HHAnnotation {
                if let selectedIndex = annotation.index {
                    let userView = UserViewController()
                    let user = users[selectedIndex]
                    userView.displayUser(user: user)
                    performSegue(withIdentifier: "displayUserProfile", sender: control)
                }
            }
            
        }
    }
    */
    

 
}
