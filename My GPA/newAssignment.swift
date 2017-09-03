//
//  newAssignment.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-22.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol AddAssignmentDelegate {
   func controller(controller: newAssignment, didSaveAssignmentWithName name: String, andGrade grade: Int, andWeight weight: Int)
}

class newAssignment: UITableViewController {
    
    var delegate: AddAssignmentDelegate?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        if let name = assignmentNameText.text, let gradeAsString = assignmentGradeText.text, let weightAsString = assignmentWeightText.text {
            
            let gradeAsFinishedString = gradeAsString.replacingOccurrences(of: "%", with: "")
            let weightAsFinishedString = weightAsString.replacingOccurrences(of: "%", with: "")
            
            let grade = Int(gradeAsFinishedString)
            let weight = Int(weightAsFinishedString)
            
            if (grade == nil || weight == nil || grade! <= 0 || weight! <= 0 || weight! > 100) {
                // Invalid entry
                
                let alert = UIAlertController(title: "Error", message: "Please check that grade and weight are inputed correctly.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if(name == "") {
                // Invalid entry
                
                let alert = UIAlertController(title: "Error", message: "Please input a name.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                // Valid entry
            
                delegate?.controller(controller: self, didSaveAssignmentWithName: name, andGrade: grade!, andWeight: weight!)
                // Notify Delegate

                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    @IBOutlet weak var assignmentNameText: UITextField!
    
    @IBAction func assingnmentNameEdited(_ sender: Any) {
        if !(assignmentNameText.text == "") {
            doneButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var assignmentGradeText: UITextField!
    
    @IBOutlet weak var assignmentWeightText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        doneButton.isEnabled = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
