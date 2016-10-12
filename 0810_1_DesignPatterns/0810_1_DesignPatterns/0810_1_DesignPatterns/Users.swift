//
//  Users.swift
//  0810_1_DesignPatterns
//
//  Created by Hamza on 12/10/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class Users: NSObject {
    static let shared = Users()
    private override init() {
        super.init()
    }
    var users = [User]()
}

extension Users {
    func removeUserAt(_ index: Int) {
        users.remove(at: index)
    }
}
