//
//  AssignmentPage.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-26.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol AssignmentPageDelegate {
    func controller(controller: AssignmentPage)
}

class AssignmentPage: UIViewController {
    
    var delegate: AssignmentPageDelegate?
    var assignment: Assignment!

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var assignmentName: UILabel!
    
    @IBOutlet weak var assignmentGrade: UILabel!
    
    @IBOutlet weak var assignmentWeight: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignmentName.text = assignment.name
        assignmentGrade.text = "Grade: \(assignment.grade)%"
        assignmentWeight.text = "Weight: \(assignment.weight)%"

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

}
