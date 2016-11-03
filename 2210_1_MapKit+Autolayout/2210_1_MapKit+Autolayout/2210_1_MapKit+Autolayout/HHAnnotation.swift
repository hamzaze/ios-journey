//
//  HHAnnotation.swift
//  2210_1_MapKit+Autolayout
//
//  Created by Hamza on 02/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import MapKit
import Foundation

class HHAnnotation: NSObject, MKAnnotation {
    var index: Int?
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
