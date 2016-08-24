//
//  _008_1_Homework5_FoodTrackerCustomControlsTests.swift
//  2008_1_Homework5_FoodTrackerCustomControlsTests
//
//  Created by Hamza on 24/08/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import XCTest
@testable import _008_1_Homework5_FoodTrackerCustomControls

class _008_1_Homework5_FoodTrackerCustomControlsTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        // Success case.
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }}
