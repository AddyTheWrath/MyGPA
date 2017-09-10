//
//  TableViewController.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-29.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol EditCourseDelegate {
    func controller(controller: courseSettings, didEditCourseWithName name: String, andEditCredit credit: Float, andEditDesiredGrade desiredGrade: Int, andCountToGPA countToGPA: Bool)
}

class courseSettings: UITableViewController {
    
    var delegate: EditCourseDelegate?
    var course: Course?
    
    @IBOutlet weak var countTowardGPASwitch: UISwitch!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let name = courseNameText.text, let desiredGradeAsString = desiredGradeText.text {
            
            let desiredGradeAsFinishedString = desiredGradeAsString.replacingOccurrences(of: "%", with: "")
            let desiredGrade = Int(desiredGradeAsFinishedString)
            
            if  (desiredGrade == nil || desiredGrade! < 0 || desiredGrade! > 100) {
                // Invalid entry
                
                let alert = UIAlertController(title: "Error", message: "Please check that desired grade is inputed correctly.", preferredStyle: UIAlertControllerStyle.alert)
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
                
                let credit = creditValueSlider.value
                var countToGPA: Bool
                
                if countTowardGPASwitch.isOn {
                    countToGPA = true
                }
                else {
                    countToGPA = false
                }
            
                delegate?.controller(controller: self, didEditCourseWithName: name, andEditCredit: credit, andEditDesiredGrade: desiredGrade!, andCountToGPA: countToGPA)
                // Notify Delegate

                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func courseNameEdited(_ sender: Any) {
        if !(courseNameText.text == "") {
            saveButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var courseNameText: UITextField!
    
    @IBOutlet weak var creditValueSlider: UISlider!
    
    @IBAction func creditValueSliderMoved(_ sender: UISlider) {
        
        sender.setValue((Float(lroundf(creditValueSlider.value/0.5))*0.5), animated: true)
        
        self.creditValueLabel.text = NSString.localizedStringWithFormat("%.1f", self.creditValueSlider.value) as String
    }
    
    @IBOutlet weak var creditValueLabel: UILabel!
    
    @IBOutlet weak var desiredGradeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseNameText.text = course?.name
        creditValueSlider.value = (course!.credit)
        creditValueLabel.text = String(format: "%.2f", course!.credit)
        desiredGradeText.text = String(course!.desiredGrade)
        
        if (course!.countToGPA) {
            countTowardGPASwitch.isOn = true
        }
        else {
            countTowardGPASwitch.isOn = false
        }
        // Pre-set previously entered values
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
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
        return 4
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
