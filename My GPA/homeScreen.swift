//
//  ViewController.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-07-24.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

class homeScreen: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: "haveRanOnce") {
        // First run of My GPA
        // Present message
        
            let alert = UIAlertController(title: "Hi there!", message: "Before adding your academic information, please click the gear icon on the home screen and set your GPA scale. Thank you!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
            defaults.set(true, forKey: "haveRanOnce")
            // Update defaults
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

