//
//  NewTableViewController.swift
//  0110_1_NetworkingJSON
//
//  Created by Hamza on 05/10/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var posts = [Post]()
    
    var postUserID = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadExternalPostsJSON()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        
        // Configure the cell...
        
        let post = posts[indexPath.row]
        cell.postNameLabel.text = post.title
        cell.postBodyLabel.text = post.body
        
        return cell
    }
    
    
    
    
    // MARK: Load external JSON for Post
    func loadExternalPostsJSON() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(postUserID)")
        
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    self.posts = [Post]()
                    
                    for postObject in json {
                        
                        var postUserId: Int?
                        var postId: Int?
                        var postTitle: String?
                        var postBody: String?
                        
                        if let userId = postObject["userId"] as? Int {
                            postUserId = userId
                        }
                        
                        if let id = postObject["id"] as? Int {
                            postId = id
                        }
                        
                        if let title = postObject["title"] as? String {
                            postTitle = title
                        }
                        
                        if let body = postObject["body"] as? String {
                            postBody = body
                        }
                        
                        let post = Post(userId: postUserId!, id: postId!, title: postTitle!, body: postBody!)
                        self.posts.append(post)
                    }
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }

}
