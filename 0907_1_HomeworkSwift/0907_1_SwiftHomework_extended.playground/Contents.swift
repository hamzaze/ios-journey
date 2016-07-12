//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//NSDate() is returning a dynamic date, instead of fixed 2016 in our computed var age in a class Person
let date = NSDate()
let calendar = NSCalendar.currentCalendar()
let components = calendar.components([.Day , .Month , .Year], fromDate: date)

struct Location {
    var latitude: Double!
    var longitude: Double!
    init() {
        latitude = Double(arc4random() % 181) - 90.0
        longitude = Double(arc4random() % 361) - 90.0
    }
}


class Person {
    var name: String!
    var lastName: String!
    var yearOfBirth: Int!
    var location: Location
    
    var age: Int {
        if !checkValidDate {
            return -2
        }
        if let yearOfBirthNew = yearOfBirth {
            if yearOfBirthNew > components.year {
                return -1
            }
            return components.year - yearOfBirth
        } else {
            return components.year
        }
    }
    
    var checkValidDate: Bool {
        let yearOfBirthString = String(yearOfBirth)
        print(yearOfBirthString.characters.count)
        if String(yearOfBirth).characters.count == 4 {
            return true
        } else {
            return false
        }
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
       var tempString = "Hi, my name is \(name) \(lastName).\nAge"
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

let student1 = Person()
student1.introduction()

let student2 = Person(name: "Michael", lastName: "Johnson", yearOfBirth: 2066, location: Location())
student2.introduction()

//2 part, it should avoid crashes even we get an empty arrays, or even nil for courses and grades

struct Course {
    var teacher: Person!
    var courseName: String!
    
    func aboutCourse() -> String {
        return "\(courseName) course by prof. \(teacher!.lastName)"
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
        var retString = ""
        retString += super.introduction() + "\nI\'m a student at \(faculty).\nMy favourite course is "
        if(attendingCourses!.isEmpty){
            retString += "[Course Name is Missing]"
        }else {
            retString += attendingCourses!.first!.aboutCourse()
        }
        retString += "\nand my AVG grade is \(averageGrade)"
        return retString
    }
}

let iOSDevelopment = Course(teacher: student1, courseName: "iOS Development")
let seo = Course(teacher: student2, courseName: "SEO")

let courses1 = [iOSDevelopment, seo]
let myGrades1 = [6, 7, 9, 10, 10, 8, 9, 10]

//Instatianting an inherited Class "Student" with non empty courses and grades, also we have an odd yearOfBirth: 19766. The system should return a default age, or even an alert message
let studentNew = Student(
    name: "Hamza1",
    lastName: "Hrnjicevic1",
    yearOfBirth: 19766,
    location: Location(),
    attendingCourses: courses1,
    grades: myGrades1
)

//calling an overriden method "introduction()"
studentNew.introduction()

let courses = [Course]()
let myGrades = [Int]()

//Instatianting an inherited Class "Student" with empty or nil courses and grades
let student = Student(
    name: "Hamza",
    lastName: "Hrnjicevic",
    yearOfBirth: 1976,
    location: Location(),
    attendingCourses: courses,
    grades: myGrades
)

//calling an overriden method "introduction()"
student.introduction()
