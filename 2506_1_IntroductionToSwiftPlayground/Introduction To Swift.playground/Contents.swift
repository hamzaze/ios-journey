//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//constants and variables

let numberOfLoops: Int = 7
let celsiusSign: String = "C"
var minTemperatureAllowed: Double = 24.5

//Type interference
let minNumberOfLoops = 1
var schoolName = "CEO International School"

//Print in Console, Playground has a built-in auto-print feature

var welcomeMessage = "Welcome"
print (welcomeMessage) // result is "Welcome"

//String interpolations
let firstExamGrade = "A"
print ("\(welcomeMessage) to \(schoolName)")
print ("Min. temperature allowed: \(minTemperatureAllowed) \(celsiusSign)")

//Comments, single line, multiline
/*
 We're introducing a new constant avgTemperature
 which represents an average temperature we've measured in all loops
 In this case it's a minTemperatureAllowed
*/
let avgTemperature = minTemperatureAllowed

//Optionals, we argue that some variable has a value
var candidateName: String! //we strongly claim that candidateName has a value
var candidateBiography: String? //we're unsure candidate will write his biography

candidateName = "Hamza Hrnjicevic"

//Optional binding, we put an optional into a temporary constant

if let newCandidateBiography = candidateBiography {
    print (newCandidateBiography) //this line should not be executed
}


if let newCandidateName: String = candidateName {
    print (newCandidateName) // This line is executed
}
//print (newCandidateName) /// Even we expect to see "Hamza Hrnjicevic" system will produce the error, as a constant is temporary, not permanent

//Operators, very similar to other program (script) languages, such as PHP, JavaScript

//Assigning
let x = 3
var a = 6
a = x
//x = a //// This produced the error as we're assigning a value to constant on initialisation, otherwise use var instead

//Arithmetic (+,-,/,*) Basis calculator operations, % - modulos
25 + 27
124.54 - 987.45
4 * 14
256 / 15
27 % 5

//Unary minus and plus (-,+)
let range = 100
let minusRange = -range
let plusMinusRange = +minusRange

//Composite operators awards, we should not use ++, --, but += 1, -=1
var y = 10
y += 3
y -= 5
y *= 6
y /= 12

//Comparison operators, return value is Boolean (true, false)
var z: Int = 5
z == y + 1
y - 3 != z
y + 1 >= z
y / 4 < z

//Ternary operators, I'm using them very often, shorten if{}else
let maxLakeLevel = 12
var openGate = maxLakeLevel > 15 ? true : false

//Operator ??
var counter: Int?
print (counter ?? 1)

//Intervals, closed (a...b) and semi-open (a..<b)
for i in 12...24{
    print ("You are currently on \(i). floor")
}

var arrMeasuredTemperature: [Double] = [26.5, 28.3, 25.8, 32.1, 24.3]
var isWarning: String = ""

for i in 0..<arrMeasuredTemperature.count {
    let currentMeasuredTemperature: Double = arrMeasuredTemperature[i]
    if currentMeasuredTemperature - minTemperatureAllowed < 0 {
        isWarning = "WARNING: "
    }
    print ("\(isWarning)Measured temperature is \(currentMeasuredTemperature)")
}

//Logical operators (!,&&,||)

if maxLakeLevel > 10 && minTemperatureAllowed < 20 {
    openGate = false
}else{
    openGate = true
}

if (maxLakeLevel > 10 && minTemperatureAllowed < 30) || numberOfLoops > 10 {
    openGate = true
}

//Strings and Characters
var messageEmpty = ""
var messgeEventIsClosed = "Sorry, this event is closed."
messageEmpty.isEmpty
if messgeEventIsClosed.isEmpty == false {
    print (messgeEventIsClosed)
}

let firstCharacterInLastname: Character = "H"

for c in schoolName.characters {
    print (c)
}

//Instantiatest the string trough the series of characaters
let characterBig: [Character] = ["B", "I", "G"]
var saleBanner = String(characterBig)

//Concatenation, (connecting) strings and characters (+,+=)
let exclamation: Character = "!"

saleBanner = saleBanner + " Sale"
saleBanner.append(exclamation)

//String interpolations, special characters, comparison
let putBanner = "\"\(saleBanner) today\", up to \(y*10)% discount\n Don\'t bee freezed at \(minTemperatureAllowed)"
let soldBanner = "SOLD"

if saleBanner == soldBanner {
    print (saleBanner)
}else{
    print (soldBanner)
}


/*
 ///// COLECTIONS ////
 Very important to me
*/

//Arrays

var arrStudentGradesNumber = [1, 2, 3, 4]
let arrStudentGradesCharacters: [Character] = ["E", "D", "C", "B", "A"]

arrStudentGradesNumber.append(5)

var studentExamName = [String] () //We are defining an empty array for students exam names
studentExamName = ["Geography", "Bosnian Language"]
studentExamName = []

//Arrays concatenation
let newStudentExamNames = ["Math", "IT Science", "Physics", "Biology", "Chemistry"]
studentExamName = studentExamName.isEmpty ? newStudentExamNames : studentExamName + newStudentExamNames

print ("Now we have \(studentExamName.count) exams.")
print ("First exam is: " + studentExamName.first!)
let restExams = studentExamName[1...3]

//Inserting and removing elements (in, from) an array

studentExamName.insert("Math 2", atIndex: 1)
var removedFromExam = studentExamName.removeAtIndex(4)
print ("We\'we removed \(removedFromExam), as we don\'t need it.")

var stringExamList: String = "Today\'s exams are:\n"
for item in studentExamName {
    stringExamList += item + "\n"
}
print (stringExamList)

//Sets (Collections) Set<Element>,  .isEmpty, .count, .insert(_:), .removeAll(), .contains(_:)

var letterCounter = Set<Character>()
var countSweeties: Int = 0;
countSweeties = 4
var removeSweetieFromShoppingList = false
let keepMyHealtPriorToSatisfaction = true
let healthyString = "healthy"
let satisfactoryString = "not so healthy"

var defaultShoppingList: Set<String> = ["Bread", "Milk", "Eggs"]
let myShoppingList: Set<String> = ["Bread", "Milk", "Juice", "Grapefruit", "Chocolate", "Mineral Water"]

var displayShoppingAlert = false

var todayShoppingList: Set<String> = defaultShoppingList.union(myShoppingList)

if todayShoppingList.isEmpty == false{
    displayShoppingAlert = true
}

if displayShoppingAlert == true {
    print ("You have to buy \(todayShoppingList.count) items today.")
    if todayShoppingList.contains("Chocolate") {
        countSweeties += 1
    }
    if countSweeties >= 5 {
        print ("Go to weigh first.")
        removeSweetieFromShoppingList = keepMyHealtPriorToSatisfaction == true ? true : false
    }
}


if removeSweetieFromShoppingList == true {
    countSweeties -= 1
    todayShoppingList.remove("Chocolate")
    if keepMyHealtPriorToSatisfaction == true && todayShoppingList.contains("Mineral Water") {
        countSweeties -= 1
        todayShoppingList.remove("Mineral Water")
    }
}

let finalHealthyString = keepMyHealtPriorToSatisfaction == true ? healthyString : satisfactoryString

print ("Your \(finalHealthyString) list is ready and it contains\n")
for item in todayShoppingList {
    print (item)
}
//remove all from shopping list
todayShoppingList.removeAll()

//Operations on sets .intersect(_:), .union(_:), .exclusiveOr(_:), .subtract(_:)

let setA: Set<Int> = [5, 6, 8, 3]
let setB: Set<Int> = [1, 2, 3, 7, 6]
setA.intersect(setB)
setA.union(setB)
setA.exclusiveOr(setB)
setA.subtract(setB)


//Dictionaries, these have a sense to me as an associative arrays or objects, probably objects as we're using JSON parser, and a syntax is similar as JavaScript objects

var carSpecification: [String: String] = ["vehicletype" : "Mini-Van", "numberOfDoors" : "4", "colour" : "Honey-Brown"]

if carSpecification.isEmpty == false {
    if carSpecification.count > 1 {
        if carSpecification["numberOfDoors"] == "5" {
            print ("This car has a glass on the trunck door.")
        }else {
            print ("The trunk of this car can not be easily loaded.")
        }
    }
}

carSpecification["numberOfDoors"] = "5"
carSpecification["numberOfSeats"] = "7"
carSpecification["vehicletype"] = nil

for (key, value) in carSpecification {
    print ("\(key) : \(value)")
}
carSpecification.removeAll()


print ("THE END OF THE TASK")




























