//: Playground - noun: a place where people can play

import UIKit
import Foundation


//Driving licence categories as an enum
enum DrivingLicenceType {
    case A, B, C, D
}

//Car class
class Car {
    var name: String
    let model: String
    let licenceType: Set<DrivingLicenceType>
    let fuelTank: Int //we might put this as :Double, more realistic
    var crossedKilometers = 0
    private var fuel: Int? //fuel in the tank
    
    //computed variable to fill up the tank
    var fuelLevel: Int { // we might put this as :Double, more realistic
        get {
            return fuel!
        }
        set {
            fuel = newValue > fuelTank ? fuelTank : newValue
        }
    }
    
    var broken = false
    var engineOn = false    
    init(
        name: String,
        model: String,
        licenceType: Set<DrivingLicenceType>,
        fuelTank: Int,
        fuelLevel: Int) {
        self.name = name
        self.model = model
        self.licenceType = licenceType
        self.fuelTank = fuelTank
        self.fuelLevel = fuelLevel
}
}
