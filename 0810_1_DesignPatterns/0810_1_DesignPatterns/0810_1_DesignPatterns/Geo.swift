//
//  Geo.swift
//  0110_1_NetworkingJSON
//
//  Created by Hamza on 05/10/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class Geo: NSObject {
    var lat: String
    var lng: String
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}
