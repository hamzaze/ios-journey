//
//  WelcomeViewController.swift
//  PlayMe
//
//  Created by Hamza on 16/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class WelcomeViewController: HHViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkCameraAndMicrophone(_ sender: UIButton) {
        AlertView.showAlertAllowCamera(self)
    }
    
    //Display selected user from annotation
    func displayRecordVideoViewController() {
        let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "recordVideo") as! RecordVideoViewController
        self.navigationController?.pushViewController(recordViewController, animated: true)
    }



}

