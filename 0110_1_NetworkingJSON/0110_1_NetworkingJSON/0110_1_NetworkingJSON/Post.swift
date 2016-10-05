//
//  Post.swift
//  0110_1_NetworkingJSON
//
//  Created by Hamza on 05/10/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class Post: NSObject {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
