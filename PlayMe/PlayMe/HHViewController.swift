//
//  HHViewController.swift
//  PlayMe
//
//  Created by Hamza on 18/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class HHViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackgroundPhoto();

        // Do any additional setup after loading the view.
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBackgroundPhoto(name: String = "Pozadina zenska"){
        var bgImage: UIImageView?
        let frameWidth = self.view.frame.size.width
        let frameHeight = self.view.frame.size.height
        
        let image: UIImage = UIImage(named: name)!
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        self.view.addSubview(bgImage!)
        self.view.sendSubview(toBack: bgImage!)

    }
}
