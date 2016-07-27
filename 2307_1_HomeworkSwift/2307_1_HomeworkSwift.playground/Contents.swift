//: Playground - noun: a place where people can play

import UIKit


//Loads Class Person, struct Location, NSDate() from earlier homework
//NSDate() is returning a dynamic date, instead of fixed 2016 in our computed var age in a class Person
let date = NSDate()
let calendar = NSCalendar.currentCalendar()
let components = calendar.components([.Day , .Month , .Year], fromDate: date)

struct Location {
    var latitude: Double?
    var longitude: Double?
    init() {
        latitude = Double(arc4random() % 181) - 90.0
        longitude = Double(arc4random() % 361) - 90.0
    }
}

class Person {
    var name: String?
    var lastName: String?
    var yearOfBirth: Int!
    var location: Location
    
    var telephone: Telephone?
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location) {
        self.name = name
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.location = location
    }
    func addTelephone(telephone: Telephone) {
        self.telephone = telephone
        telephone.delegate = self
    }
    
    func removeTelephone() {
        telephone = nil
        telephone?.delegate = nil
    }
}

//New things here....

struct Contact {
    var name: String
    var phoneNumber: String
}

class Message {
    enum Status {
        case Received, Read
    }
    let sender: Contact
    let text: String
    var status: Status = .Received
    
    init(sender: Contact, text: String) {
        self.sender = sender
        self.text = text
    }
    
    func changeStatusToRead() {
        status = .Read
    }
}

//New protocol that can be implemented over the Classes only and it receives a func
protocol MessageHandlerDelegate: class {
    func didReceiveMessage(message: Message)
}

class Telephone {
    private var messages: [Message]=[Message]()
    var model: String
    weak var delegate: MessageHandlerDelegate?
    
    init(model: String) {
        self.model = model
    }
    
    func addNewMessage(message: Message) {
        messages.append(message)
        delegate?.didReceiveMessage(message)
    }
}

extension Person: MessageHandlerDelegate {
    func didReceiveMessage(message: Message) {
        readMessage(message)
    }
    
    private func readMessage(message: Message) {
        message.changeStatusToRead()
        print("Hey I\'ve got this message from \(message.sender.name): \(message.text)")
    }
}


///Implementations

let telephone = Telephone(model: "iPhone 6S")
var x = Person(name: "Hamza", lastName: "Hrnjicevic", yearOfBirth: 1976, location: Location())
x.addTelephone(telephone)

var contactPerson1 = Contact(name: "Didier Drogba", phoneNumber: "+387(0)61 123 456")
var contactPerson2 = Contact(name: "Michael Johnson", phoneNumber: "+387(0)61 987 654")

var message1 = Message(sender: contactPerson1, text: "Hey Hamza, are we going to play a soccer tonight?")
var message2 = Message(sender: contactPerson2, text: "I heard Alen Tuka will beat my record in Rio. Do you think?")
var message3 = Message(sender: contactPerson1, text: "Ibra has just confirmed. We still need 1 player, answer meee.....!")

//Person x has this telephone
print(x.telephone?.model)

telephone.addNewMessage(message1)
telephone.addNewMessage(message2)

x.removeTelephone()
telephone.addNewMessage(message3)

//Person x has no telephone
print(x.telephone?.model)





















