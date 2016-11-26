//
//  AfterVideoRecordedViewController.swift
//  PlayMe
//
//  Created by Hamza on 26/11/2016.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

class AfterVideoRecordedViewController: HHViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func dismissViewButton(_ sender: HHButton) {
        _ = navigationController?.popViewController(animated: true)
    }

}
