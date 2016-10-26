//
//  ServerComunication.swift
//  0810_1_DesignPatterns
//
//  Created by Hamza on 12/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class ServerComunication: NSObject {
    static var shared = ServerComunication()
    
    private override init() {
        super.init()
    }
    
    func refreshUsers() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                do {
                    Users.shared.users = [User]()
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    for userObject in json {
                        
                        let userUser = User()
                        
                        if let id = userObject["id"] as? Int {
                            userUser.id = id
                        }
                        
                        if let name = userObject["name"] as? String {
                            userUser.name = name
                        }
                        
                        if let username = userObject["username"] as? String {
                            userUser.username = username
                        }
                        
                        if let email = userObject["email"] as? String {
                            userUser.email = email
                        }
                        
                        //Check for address object and dive into
                        if let addressObject = userObject["address"] as? [String: AnyObject] {
                            
                            let userAddress = Address()
                            
                            if let street = addressObject["street"] as? String {
                                userAddress.street = street
                            }
                            
                            if let suite = addressObject["suite"] as? String {
                                userAddress.suite = suite
                            }
                            
                            if let city = addressObject["city"] as? String {
                                userAddress.city = city
                            }
                            
                            if let zipcode = addressObject["zipcode"] as? String {
                                userAddress.zipcode = zipcode
                            }
                            
                            //Check for geo object and dive into
                            if let geoObject = addressObject["geo"] as? [String: AnyObject] {
                                let userAddressGeo = Geo()
                                
                                if let lat = geoObject["lat"] as? String {
                                    userAddressGeo.lat = lat
                                }
                                
                                if let lng = geoObject["lng"] as? String {
                                    userAddressGeo.lng = lng
                                }
                                
                                userAddress.geo = userAddressGeo
                            }
                            userUser.address = userAddress
                        }
                        
                        if let phone = userObject["phone"] as? String {
                            userUser.phone = phone
                        }
                        
                        if let website = userObject["website"] as? String {
                            userUser.website = website
                        }
                        
                        //Check for company object and dive into
                        if let companyObject = userObject["company"] as? [String: AnyObject] {
                            let company = Company()
                            if let name = companyObject["name"] as? String {
                                company.name = name
                            }
                            
                            if let catchPhrase = companyObject["catchPhrase"] as? String {
                                company.catchPhrase = catchPhrase
                            }
                            
                            if let bs = companyObject["bs"] as? String {
                                company.bs = bs
                            }
                            
                            userUser.company = company
                       }
                        //Add user (JSON) to User (Singleton)
                        Users.shared.users.append(userUser)
                    }
                    
                    DispatchQueue.main.sync {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UsersRefreshed"), object: nil)
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
