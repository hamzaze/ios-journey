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
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                do {
                    Users.shared.users = [User]()
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    
                    
                    for userObject in json {
                        
                        var userID: Int?
                        var userName: String?
                        var userUserName: String?
                        var userEmail: String?
                        var userAddress: Address?
                        var userPhone: String?
                        var userWebsite: String?
                        var userCompany: Company?
                        
                        if let id = userObject["id"] as? Int {
                            userID = id
                        }
                        
                        if let name = userObject["name"] as? String {
                            userName = name
                        }
                        
                        if let username = userObject["username"] as? String {
                            userUserName = username
                        }
                        
                        if let email = userObject["email"] as? String {
                            userEmail = email
                        }
                        
                        //Check for address object and dive into
                        if let addressObject = userObject["address"] as? [String: AnyObject] {
                            
                            var userAddressStreet: String?
                            var userAddressSuite: String?
                            var userAddressCity: String?
                            var userAddressZipcode: String?
                            var userAddressGeo: Geo?
                            
                            if let address = addressObject["street"] as? String {
                                userAddressStreet = address
                            }
                            
                            if let suite = addressObject["suite"] as? String {
                                userAddressSuite = suite
                            }
                            
                            if let city = addressObject["city"] as? String {
                                userAddressCity = city
                            }
                            
                            if let zipcode = addressObject["zipcode"] as? String {
                                userAddressZipcode = zipcode
                            }
                            
                            //Check for geo object and dive into
                            if let geoObject = addressObject["geo"] as? [String: AnyObject] {
                                
                                var userAddressGeoLat: String?
                                var userAddressGeoLng: String?
                                
                                if let lat = geoObject["lat"] as? String {
                                    userAddressGeoLat = lat
                                }
                                
                                if let lng = geoObject["lng"] as? String {
                                    userAddressGeoLng = lng
                                }
                                
                                userAddressGeo = Geo(lat: userAddressGeoLat!, lng: userAddressGeoLng!)
                            }
                            
                            userAddress = Address(street: userAddressStreet!, suite: userAddressSuite!, city: userAddressCity!, zipcode: userAddressZipcode!, geo: userAddressGeo!)
                        }
                        
                        if let phone = userObject["phone"] as? String {
                            userPhone = phone
                        }
                        
                        if let website = userObject["website"] as? String {
                            userWebsite = website
                        }
                        
                        //Check for company object and dive into
                        if let companyObject = userObject["company"] as? [String: AnyObject] {
                            var userCompanyName: String?
                            var userCompanyCatchPhrase: String?
                            var userCompanyBS: String?
                            
                            if let name = companyObject["name"] as? String {
                                userCompanyName = name
                            }
                            
                            if let catchPhrase = companyObject["catchPhrase"] as? String {
                                userCompanyCatchPhrase = catchPhrase
                            }
                            
                            if let bs = companyObject["bs"] as? String {
                                userCompanyBS = bs
                            }
                            
                            
                            userCompany = Company(name: userCompanyName!, catchPhrase: userCompanyCatchPhrase!, bs: userCompanyBS!)
                        }
                        
                        let user = User(id: userID!, name: userName!, username: userUserName!, email: userEmail!, address: userAddress!, phone: userPhone!, website: userWebsite!, company: userCompany!)
                        Users.shared.users.append(user)
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
