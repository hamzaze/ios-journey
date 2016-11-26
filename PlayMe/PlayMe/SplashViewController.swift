//
//  SplashViewController.swift
//  PlayMe
//
//  Created by Hamza on 25/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadBackgroundPhoto(name: "Splash screen")
        perform(#selector(SplashViewController.showNavController), with: nil, afterDelay: 1)
    }
    
    func showNavController() {
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBackgroundPhoto(name: String){
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
