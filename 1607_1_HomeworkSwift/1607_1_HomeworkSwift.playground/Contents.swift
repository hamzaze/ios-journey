//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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

struct Course {
    var teacher: Person?
    var courseName: String?
    
    func aboutCourse() -> String {
        return "\(courseName!) course by prof. \(teacher!.lastName!)" //I put ! at the end of the object to avoid "Optional(object)" print, just print "[object]"
    }
}

class Person {
    var name: String?
    var lastName: String?
    var yearOfBirth: Int!
    var location: Location
    weak var father: Parent?
    weak var mother: Parent?
    var age: Int {
        if !checkValidDate {
            return -2
        }
        if let yearOfBirthNew = yearOfBirth {
            if yearOfBirthNew > components.year {
                return -1
            }
            return components.year - yearOfBirth!
        } else {
            return components.year
        }
    }
    
    var checkValidDate: Bool {
        if String(yearOfBirth).characters.count == 4 {
            return true
        } else {
            return false
        }
    }
    
    deinit {
        print("\(name) \(lastName) born \(yearOfBirth) is being deinitialized")
    }
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location) {
        self.name = name
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.location = location
    }
    
    convenience init() {
        self.init(
            name: "[Missing First Name]",
            lastName: "[Missing Last Name]",
            yearOfBirth: 1990,
            location: Location()
        )
    }
    
    func introduction() -> String {
        var tempString = "Hi, my name is \(name!) \(lastName!).\nAge"
        switch(age) {
        case -1:
            tempString += " [WETHER YOU ARE A TIME TRAVELER?]"
        case -2:
            tempString += " [YOU SHOULD PUT A VALID YYYY BIRTH DATE]"
        default:
            tempString += " \(age)."
        }
        return tempString
    }
}

class Parent: Person {
    var children: [Person]
    var savings: Double?
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location, children: [Person]) {
        self.children = children
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    
    override convenience init(name: String, lastName: String, yearOfBirth: Int, location: Location) {
        self.init(
            name: name,
            lastName: lastName,
            yearOfBirth: yearOfBirth,
            location: location,
            children: [Person]()
        )
    }
    
    override func introduction() -> String {
        var retString = ""
        retString += super.introduction()
        if(!children.isEmpty){
            retString += " I\'m a parent of \(children.count)"
        }
        return retString
    }
}

class Student: Person {
    var attendingCourses: [Course]?
    var grades: [Int]?
    var faculty = "WiP"
    
    var averageGrade: Double {
        var sum = 0
        if grades!.isEmpty {
            return Double(sum)
        } else {
            for grade in grades! {
                sum += grade
            }
            return Double(sum / grades!.count)
        }
    }
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location, attendingCourses: [Course], grades: [Int]) {
        self.attendingCourses = attendingCourses
        self.grades = grades
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    
    
    
    override func introduction() -> String {
        let fatherSavings = father?.savings
        let motherSavings = mother?.savings
        print("Father savings is \(fatherSavings), Mother savings is \(motherSavings!)")
        var retString = ""
        retString += super.introduction() + "\nI\'m a student at \(faculty).\nMy favourite course is "
        if(attendingCourses!.isEmpty){
            retString += "[Course Name is Missing]"
        }else {
            retString += attendingCourses!.first!.aboutCourse()
        }
        retString += "\nand my AVG grade is \(averageGrade)"
        //I tried to make this using guard but I got "My parents are broke" even motherSavings is not a nil
        // I put this
        //     guard fatherSavings == nil && motherSavings == nil {
        //       retString += ". My parents are broke."
        //       return retString
        //    }

        //
        //
        if fatherSavings == nil && motherSavings == nil {
            retString += ". My parents are broke."
            return retString
        }
        
        if fatherSavings != nil {
            retString += ". My father has $\(fatherSavings!) savings."
        }
        if motherSavings != nil {
            retString += ". My mother has $\(motherSavings!) savings."
        }
        return retString
    }
}

let student1 = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: Location())
let student2 = Person(name: "Michael", lastName: "Johnson", yearOfBirth: 2066, location: Location())


let iOSDevelopment = Course(teacher: student1, courseName: "iOS Development")
let seo = Course(teacher: student2, courseName: "SEO")

let courses1 = [iOSDevelopment, seo]
let myGrades1 = [6, 7, 9, 10, 10, 8, 9, 10]


//Task 2 relies on a previous (+bonus) homework 0907_1_SwiftHomework_extended
//These class are written above this comment



//Extending struct with method

extension Int {
    func ageInDays() -> Int{
        return self * 365
    }
}

//Class instantiating

let student = Student(
    name: "Hamza",
    lastName: "Hrnjicevic",
    yearOfBirth: 1976,
    location: Location(),
    attendingCourses: courses1,
    grades: myGrades1
)

let brother = Person(
    name: "Adis",
    lastName: "Hrnjicevic",
    yearOfBirth: 1973,
    location: Location()
)


let father = Parent(
    name: "Dzemal",
    lastName: "Hrnjicevic",
    yearOfBirth: 1945,
    location: Location(),
    children: [student, brother]
)

let mother = Parent(
    name: "Murisa",
    lastName: "Bico",
    yearOfBirth: 1950,
    location: Location(),
    children: [student, brother]
)

mother.savings = Double(arc4random() % 10000)
print(mother.savings!)

student.father = father
student.mother = mother

father.introduction()
mother.introduction()
student.introduction()

let studentAgeInDays = student.age.ageInDays()
let brotherAgeInDays = brother.age.ageInDays()
let fatherAgeInDays = father.age.ageInDays()
let motherAgeInDays = mother.age.ageInDays()

let myFamilyAgeInDays = studentAgeInDays + brotherAgeInDays + fatherAgeInDays + motherAgeInDays




















