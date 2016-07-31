import UIKit
import Foundation

//function to print anything, with a delay
func delayedPrint(text: String){
    usleep(500000)
    print(text)
}

//Driving licence categories as an enum
enum DrivingLicenceType {
    case A, B, C, D
}

//Protocol for the class types only
protocol DrivingLicence {
    var drivingLicence: Set<DrivingLicenceType> {get}
}

//Protocol for the car state, fuel level or an engine health
protocol CarMonitoringDelegate {
    func engineBroke()
    func lowOnFuel()
    func outOfFuel()
}

class Person {
    let firstName: String
    let lastName: String
    let age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

//inherited classes from Person, (Driver, Mechanic)
class Driver: Person, DrivingLicence{
    var drivingLicence: Set<DrivingLicenceType>
    weak var mechanic: Mechanic?
    weak var car: Car?
    
    init(drivingLicence: Set<DrivingLicenceType>, firstName: String, lastName: String, age: Int) {
        self.drivingLicence = drivingLicence
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    func callMechanic(mechanic: Mechanic, toFixACar car: Car) {
        let isEmptyMatchMechanicCarIntersect = mechanic.authorizedServicerForLicenceTypes.intersect(car.licenceType)
        guard isEmptyMatchMechanicCarIntersect.isEmpty == false else {
            delayedPrint("Mechanic responded he can not fix this car")
            return
        }
        delayedPrint("Mechanic responded he can fix this car")
        mechanic.fixCar(car)    }
    
    func driveCar() {
        let matchDriverAndCarLicences = drivingLicence.intersect(car!.licenceType)
        if matchDriverAndCarLicences.isEmpty {
            delayedPrint("THIS DRIVER IS NOT PROVIDED TO DRIVE THIS CAR");
            return
        }
        car?.drive()
    }
}

class Mechanic: Person {
    let authorizedServicerForLicenceTypes: Set<DrivingLicenceType>
    
    init(authorizedServicerForLicenceTypes: Set<DrivingLicenceType>, firstName: String, lastName: String, age: Int) {
        self.authorizedServicerForLicenceTypes = authorizedServicerForLicenceTypes
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    func fixCar(car: Car) {
        delayedPrint("\(firstName) \(lastName) is fixing car")
        car.broken = false
        delayedPrint("Car fixed")
    }
}


//Car class
class Car {
    var name: String
    let model: String
    let licenceType: Set<DrivingLicenceType>
    let fuelTank: Int //we might put this as :Double, more realistic
    var crossedKilometers = 0
    private var fuel: Int //fuel in the tank
    
    //computed variable to fill up the tank
    var fuelLevel: Int { // we might put this as :Int, but :Double is closer to the real case
        get {
            return fuel
        }
        set{
            fuel = newValue > fuelTank ? fuelTank : newValue
        }
    }
    
    var broken = false
    var engineOn = false
    var driver: DrivingLicence? //driver must meet the requirements set in a protocol DrivingLicence, ie. he must have one of the driving licence type A-E
    
    var delegate: CarMonitoringDelegate?
    
    init(
        name: String,
        model: String,
        licenceType: Set<DrivingLicenceType>,
        fuelTank: Int,
        fuel: Int) {
            self.name = name
            self.model = model
            self.licenceType = licenceType
            self.fuelTank = fuelTank
            self.fuel = fuel
    }
    
    //methods
    func stop() {
        engineOn = false
    }
    
    func drive() {
        delayedPrint("Starting engine")
        engineOn = true
        repeat {
            let chanceForBrokenEngine = Int(arc4random_uniform(100)) + 1 //We put this in a constant for better debuging what chances, for the engine to be broken, we're getting in each iteration
            guard broken == false else {
                delayedPrint("Engine broke")
                delegate?.engineBroke()
                stop()
                break
            }
            guard fuelLevel > 0 else {
                delayedPrint("Empty fuel tank")
                delegate?.outOfFuel()
                break;
            }
            if fuelLevel <= 10 { //From my experience I think <= is better than ==
                delayedPrint("Fuel low")
                delegate?.lowOnFuel()
            }
            fuelLevel -= 1
            crossedKilometers += 10
            //delayedPrint("chanceForBrokenEngine = \(chanceForBrokenEngine)")
            broken = chanceForBrokenEngine == 1 ? true : false
            
        } while engineOn == true
    }
}

extension Driver: CarMonitoringDelegate {
    func engineBroke() {
        delayedPrint("Calling a mechanic")
        callMechanic(mechanic!, toFixACar: car!)
    }
    
    func lowOnFuel() {
        let isDriverAddingSomeFuelNow = Int(arc4random_uniform(3)) + 1
        switch isDriverAddingSomeFuelNow {
        case 1,2:
            let someFuelNewValue = Int(arc4random_uniform(UInt32(car!.fuelTank))) + 1
            delayedPrint("I will add some gas now.")
            car!.fuel = someFuelNewValue
            delayedPrint("Added fuel. Current fuel level \(car!.fuelLevel)")
        default:
            delayedPrint("I will add some gas later")
        }
    }
    
    func outOfFuel() {
        let someFuelNewValue = Int(arc4random_uniform(UInt32(car!.fuelTank))) + 1
        delayedPrint("I will add soem gas now.")
        car!.fuel = someFuelNewValue
        delayedPrint("Added fuel. Current fuel level \(car!.fuelLevel)")
    }
}


//Simulation

let driver = Driver(drivingLicence: [DrivingLicenceType.B, DrivingLicenceType.C], firstName: "Hamza", lastName: "Hrnjicevic", age: 40)
let car = Car(name: "Citroen", model: "Xsara Picasso", licenceType: [DrivingLicenceType.B], fuelTank: 70, fuel: 0)
let mechanic = Mechanic(authorizedServicerForLicenceTypes: [DrivingLicenceType.B, DrivingLicenceType.C, DrivingLicenceType.D], firstName: "Anel", lastName: "Hadzic", age: 26)

driver.car = car
car.delegate = driver
driver.mechanic = mechanic

for _ in 1...10 {
    driver.driveCar()
}

delayedPrint("Car crossed \(car.crossedKilometers) km in this run")
