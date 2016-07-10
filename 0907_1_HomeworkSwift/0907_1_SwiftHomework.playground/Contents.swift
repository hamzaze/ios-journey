//: Playground - noun: a place where people can play

import UIKit

//1st Part

struct Location {
    var latitude: Double
    var longitude: Double
    init() {
        latitude = Double(arc4random() % 181) - 90.0
        longitude = Double(arc4random() % 361) - 90.0
    }
}

class Person {
    var name: String
    var lastName: String
    var yearOfBirth: Int
    var location: Location
    
    var age: Int {
        return 2016 - yearOfBirth
    }
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location) {
        self.name = name
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.location = location
    }
    
    convenience init(name: String, lastName: String) {
        self.init(
            name: name,
            lastName: lastName,
            yearOfBirth: 1990,
            location: Location()
        )
    }
    
    func introduction() -> String {
        return "Hi, my name is \(name) \(lastName). Age \(age)."
    }
}

//mirko and nedim are new objects "Person()", with initialized values
let mirko = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: Location())
let nedim = Person(name: "Nedim", lastName: "Sabic", yearOfBirth: 1982, location: Location())

//we are calling a method "introduction()" on new created objects
mirko.introduction()
nedim.introduction()

//2nd Part

struct Course {
    var teacher: Person
    var courseName: String
    
    func aboutCourse() -> String {
        return "\(courseName) course by prof. \(teacher.lastName)"
    }
}

class Student: Person {
    var attendingCourses = [Course]()
    var grades = [Int]()
    var faculty = "WiP"
    
    var averageGrade: Double {
        var sum = 0
        for grade in grades {
            sum += grade
        }
        return Double(sum / grades.count)
    }
    
    init(name: String, lastName: String, yearOfBirth: Int, location: Location, attendingCourses: [Course], grades: [Int]) {
        self.attendingCourses = attendingCourses
        self.grades = grades
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    
    override func introduction() -> String {
        return super.introduction() + " I\'m a student at \(faculty). My favourite course is " + attendingCourses.first!.aboutCourse()
    }
}

let iOSDevelopment = Course(teacher: mirko, courseName: "iOS Development")
let seo = Course(teacher: nedim, courseName: "SEO")

let myGrades = [6, 7, 9, 10, 10, 8, 9, 10]

let courses = [seo, iOSDevelopment]
//Instatianting an inherited Class "Student"
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