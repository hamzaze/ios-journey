//: Playground - noun: a place where people can play

import UIKit

var a: [String] = ["First", "Second", "Third"]

//I made a function to create a multidimensional array

func createMultiDimensionalArray(array: [String]) -> [[String]] {
    var b = [[String]]()
    for _ in 1...2 {
    var counter = 0
        for _ in array {
            var c = array
            var tempA = c[0]
            tempA += "\(counter)"
            c[0]=tempA
            b.append(c)
            counter += 1
        }
    }
    return b
}

//this is a new created multidimensional array
var b = createMultiDimensionalArray(a)

//Defining dictionary
var d = [String:[[String]]]()


//What to write here to get d (multidimensional dictionary) in this format
/*
 d = ["First0": [["First0", "Second", "Third], ["First0", "Second", "Third]],
     "First1": [["First1", "Second", "Third], ["First1", "Second", "Third]],
     "First2": [["First2", "Second", "Third], ["First2", "Second", "Third]]
    ]
 
*/


// I tried with this
var counter1=0;
if !b.isEmpty {
    for i in 0...b.count-1 {
        for j in 0...b[i].count-1 {
            //What to write here to get d (multidimensional dictionary)
            //d[b[i]][0] = [b[i]]
        }
    }
}
print(d)
