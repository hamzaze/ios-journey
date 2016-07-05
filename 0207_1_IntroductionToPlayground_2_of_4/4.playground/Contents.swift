//: Playground - noun: a place where people can play

import UIKit

var str = "BAJRAM SERIF MUBAREK OLSUN"

/*
 Flow Control
 Functions
 Closures
 Enumerations
*/

//Flow Control
// - Loops: for-in, while, repeat-while
// - Branching: if, guard, switch
// - Transfer Control: break, continue, fall trough guard

//Loops
//For-in
// - The most used loop
// - It iterates trough entire collection or interval

//Example//

let endOfInterval = 10
var result = 3
var loopSuffix = ""

for i in 1...endOfInterval {
    if i > 3 { loopSuffix = "th" }
    else if i == 3 { loopSuffix = "rd" }
    else if i == 2 { loopSuffix = "nd" }
    else if i == 1 { loopSuffix = "st" }
    print("In \(i)\(loopSuffix) loop the result is \(result*i).")
}

// - If we need nor collection nor interval value we're using an underscore "_"
//Example//
for _ in 1...result {
    print("Do something with your life!")
}

// - Iterating trough collections
//Example//
let myCodingSkills = ["PHP", "MySQL", "HTML(5)", "CSS(3)", "JavaScript (jQuery)"]
var finalCodingSkillsString = "My current coding skills are:\n"
for name in myCodingSkills {
    finalCodingSkillsString += name + "\n"
}
print(finalCodingSkillsString)

//Example Tuple//
let pointsPerSubject = ["Math": 30, "Physic": 25, "IT": 50, "Logic": 30]
for (subject, point) in pointsPerSubject {
    print("\(subject): \(point) points")
}

//While
//- It begins by checking some condition, if it is a "true", all orders within it are executing until that condition have changed to a "false"
//Example
var numberList = [15, 28, 11, 8, 0, -67, 3]
var evenNumbers = [Int]()
var oddNumbers = [Int]()
while numberList.isEmpty == false {
    var currNumber = numberList.removeAtIndex(0)
    if currNumber % 2 == 0 {
        evenNumbers.append(currNumber)
    } else {
        oddNumbers.append(currNumber)
    }
}
print("We have \(evenNumbers.count) even elements and \(oddNumbers.count) odd elements.")

//Repeat-while
//- While loop variation - similar to PHP do while
// - It assures executing an order at least once, after what it checks a condition. It repeats orders until the condition is becoming "false"
//Example//
var countDown = 10
repeat {
    print(countDown)
    countDown -= 1
} while countDown > -1

//Branching
//If clause
//In the case it's a true, it executes the order
//Example//
let timeToGo: Double = 10
if timeToGo > 9 {
    print("You should take a bus at 09:50")
}

//If clause supports an "else" expression, which is executing if the if order is not true
//Example//
if timeToGo <= 9.40 {
    print("You should take a bus at 09:50")
} else {
    print("Buy a new alarm clock!")
}

//Switch order
//- It takes a value and compares with multiple value cases
//- If we need to compare that value with multiple values, we split those values
//- If we might not have a supported case, we're adding a "default"
//Example//
let jacketSize: String = "XXXL"
switch jacketSize {
    case "L", "S", "M":
        print("Infant size")
    case "XL", "XXL":
        print("Adult size")
    default:
        print("Basketball size")
}

//Example 2//
let shoeNumber = 48
switch shoeNumber {
    case 1...37:
        print("Children's shoes models")
    case 38...46:
        print("Adult's shoes models")
    default:
        print("Choose a shoe model you would like to play a basketball with")
}

//Transfer Control
//Continue 
//- It is used in loops
//- It orders to the loop to stop with a current iteration and move on the next iteration
//Example//
var finalPositiveEvenNumbers = [Int]()
for number in evenNumbers {
    switch number {
    case 0:
        continue
    default:
        if number % 2 == 0 {
            finalPositiveEvenNumbers.append(number)
        }
    }
    
}
for i in finalPositiveEvenNumbers {
    print ("Positive even number is \(i)")
}

//Break
//- It's used in loops and it breaks the loop
for number in oddNumbers {
    if number <= 0 {
        break;
    }else{
        print("System is checking a positive number: \(number)")
    }
}

//Fallthrough
//- We're using it in a switch order
//- It talks to the switch it is going to execute all cases declared right bellow it, while it won't check that case including a default. (I didn't get this at all)
//Example//
var whoIsBuyingShoes = "A person with a shoe number \(shoeNumber) is"
switch shoeNumber {
case 1...37:
    print("Children's shoes models")
case 38...46:
    print("Adult's shoes models")
    case 47...54:
    whoIsBuyingShoes += " tall and probably"
    fallthrough
default:
    whoIsBuyingShoes += " like to play a basketball"
}

//Guard
//- It's very similar to "If"
//- We're using it to early exit from the loop
//- It always contains an else statement where it have an order for the case the expression is not met

let newOddNumbers = [1, 3, 5, 7, 9, 11, 13, 15]
for number in newOddNumbers {
    guard number > 2 else {
        print("We have 1 and the code should stop here.");
        break
    }
    print("Next number is: \(number)\n");
}

//Functions
//- They keep a piece of the code which is executing some specific task
//- They have a name
//- We're executing it by writing it's name

//Definition
//- Functions can accept arguments/parameters/values
//- They can return values (more than one!)
//- They're defined by a key word "func", behind it we write it's "name" and "()", (we might add some parameters there). Optionally we're adding a "->Type" if the function is returning some value, and finally brackets "{}"
//Example//
func squareNumbers(a: Int) -> Int {
    return a * a
}

//Calling
//- We're calling functions by writing it's name with () at the end, if it accepts some arguments, we're writing them in ()
//Example//
var newSquareNumber = squareNumbers(15)

//Arguments and return values
//-They're very flexible in a Swift
//-Functions can have none, one or more arguments, including different options
//Functions with no arguments
//Example//
func discountIsOnMessage() -> String {
    return "This item is on discount!"
}

print(discountIsOnMessage())

//Functions with arguments
//- We're writing them following this rule: "func functionName(arg1: Type, arg2: Type, ...)"
//- We're calling them by this rule: "functionName(value1, arg2: value2, arg3: value3, ...)"
//Example//
func greetingMessage(greeting: String, toWho: String){
    print("\(greeting) \(toWho)!")
}

greetingMessage("Welcome", toWho: "to our shop")
greetingMessage("Thanks", toWho: "for visiting us")
//the function above is returning no value

//Functions which are returning mixed values (tuple), we can use optionals here "?"

func getMinMaxAvg(array: [Int]) -> (min: Int, max: Int, sum: Int)? {
    if array.isEmpty {
        return nil
    }
    var newMin = array[0]
    var newMax = array[0]
    var sum = 0
    for number in array[1..<array.count] {
        sum += number
        if number < newMin {
            newMin = number
        } else if number > newMax {
            newMax = number
        }
    }
    return (newMin, newMax, sum)
}

if let newArray = getMinMaxAvg(newOddNumbers) {
    print("The smallest number is \(newArray.min)")
    print("The largest number is \(newArray.max)")
    print("The sum of all numbers is \(newArray.sum)")
}

//Function argument names
//- There are two names for a function arguments: local, external
//- By the rule the first argument name is an external name in a function argument
//- Argument names are increasing a function readability
// - "func functionName(ext int: Type, ext int: Type)"
//Example
func drivingRoute(from city1: String, to city2: String) -> String{
    return "You are driving from \(city1) to \(city2)"
}

print(drivingRoute(from: "Zenica", to: "Travnik"))

//Standard argument values
//- "func functionName(arg1: Type = value1, arg2: Type = value2, ...)"
//Example//
func basisDrivingRoute(from city1: String = "Zenica", to city2: String = "Travnik") -> String {
    return "Your today's driving route is: \(city1) - \(city2)"
}

print(basisDrivingRoute(from: "Sarajevo", to: "Mostar"))

print(basisDrivingRoute())

//Variadic function arguments
//- They accepts 0 or more the same type values
//- They're writing using "..." behind the argument type
//- Function can contain at most one variadic argument, "func functionName(arg: Type...)"
func avgTemperature(temperatures: Double...) -> Double? {
    var sum: Double = 0
    if temperatures.isEmpty {
        return nil
    }
    for i in temperatures {
        sum += i
    }
    return sum / Double(temperatures.count)
}

avgTemperature(27.6, 31.2, 18, 29.1)

//In-out arguments
//- They're changing variable values defined out of the function
//- Syntax: "func functionName(inout arg1: Type, inout arg2: Type, ...)"
//- When calling, we're passing in-out arguments with "&" in the front of the argument name
//Example//
func swapFirstLastNames(inout name1: String, inout _ name2: String){
    let tempName = name1
    name1 = name2
    name2 = tempName
}

var arrStudentName1 = "Durant"
var arrStudentName2 = "Kevin"
swapFirstLastNames(&arrStudentName1, &arrStudentName2)
print("\(arrStudentName1) \(arrStudentName2)")

//Function like a type
//In () we're adding types what function's accepting and -> Type which it returns: "(Type, Type, ...) -> Type
//Example//
func cubicNumber(a: Int) -> Int {
    return a * a * a
}

var calculateCubic: (Int) -> Int = cubicNumber
print(calculateCubic(10))

//Nested functions, (function in a function), they're not available out of the scope
//Example//
func goAction(multiply arg1: Int){
    var counter = 0
    func startAction(arg2: Int) -> Int {
        counter += 1
        return (arg2 + counter) * (1000 / counter)
    }
    for _ in 1...7 {
        startAction(arg1)
    }
}

goAction(multiply: 1)
goAction(multiply: 2)
goAction(multiply: 3)
goAction(multiply: -3)
//startAction(5) // This has produced the error, it is out of the scope



//CLOSURE
//- Self-sustaining block of functionalities which are transfering and using in a code
//- They can contain a reference to variables from the context they're defined from
//- They're very similar to functions but then don't have "func functionName"
/*- Syntax: "{ (args) -> return type in
                statements
            }"
*/

let textServerRequestInitialized = {(time: String) -> String in
    return "Server request initialized at \(time)"
}
var currentTime = "00:34"
print(textServerRequestInitialized(currentTime))

//Closure as a last function argument
//- If a closure is a last argument, it's body may be written after () u {}
//Example//
func testFunctionWithClosure(closure: () -> Void) {
    print("Something here")
}

testFunctionWithClosure({
    print("Something here")
})

testFunctionWithClosure(){
    print("Something here")
}
//In this case, as we have a closure as the only argument we can write it like this
testFunctionWithClosure{
    print("Something here")
}

//Notice: I'm not 100% clear with closure, but I'm starting to getting their basis aim

//Enumerations
//- They're grouping similar connected values
//- They're more flexible than other programming languages as they can have:
// - different types
// - calculated values
// - methods

//- We're using them in switches and functions mostly
//- Syntax: "enum NameOfAnEnum {} // spot all camel cases
//Example//
enum BasisCMYKColour {
    case Cyan
    case Magenta
    case Yellow
    case Key //Black
}
//We could write an above enum in this format
enum BasisCMYKColourInline {
    case Cyan, Magenta, Yellow, Key //Black
}

var missingColour = BasisCMYKColour.Yellow
print(missingColour)
missingColour = .Cyan
print(missingColour)

//We can pass enum(s) as an function argument, and they're checking in a switch

func checkAreAllDTPColoursAtThePlace(color: BasisCMYKColour){
    switch color {
    case .Cyan:
        print("Cyan is at the place")
    case .Magenta:
        print("Magenta is at the place")
    case .Yellow:
        print("Yellow is at the place")
    case .Key:
        print("Black is at the place")
    }
}

checkAreAllDTPColoursAtThePlace(.Key)

//Raw values
//Example//
enum WeekNameUK: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 5
    case Saturday = 6
    case Sunday = 7
}

var currentDayInAWeek = WeekNameUK.Tuesday
var currentDayInAWeekNumber = currentDayInAWeek.rawValue
print("Today is \(currentDayInAWeek) and it is \(currentDayInAWeekNumber). day in a Week.")

//When we're using Int as an enum Type, all cases are zero indexed, (from 0 to n)
//Example//
enum WeekNameUKSundayFirst: Int {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

var whatDayToRest = WeekNameUKSundayFirst.Sunday
var whatDayIsFirstInAWeek = WeekNameUK(rawValue: 1)
print("Go and get rest on \(whatDayToRest)")
print("Work hard on \(whatDayIsFirstInAWeek)")

//Enum(s) are nice feature, and I see them very usable

//THE END//