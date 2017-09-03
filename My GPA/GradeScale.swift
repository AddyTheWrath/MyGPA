//
//  GradeScale.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-29.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol GradeScaleDelegate {
    func controller(controller: GradeScale)
}

class GradeScale: UITableViewController {
    
    var gradeModified = 0
    var delegate: GradeScaleDelegate?
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let minRequiredAsFinishedString = minRequiredText.text?.replacingOccurrences(of: "%", with: "")
        // Accept value user inputs x or x%
        
        let minGrade = Int(minRequiredAsFinishedString!)
        
        if  (minGrade == nil || minGrade! < 0 || minGrade! > 100) {
            // Invalid entry
            
            let alert = UIAlertController(title: "Error", message: "Please check that minimum grade is inputed correctly.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // Valid entry

            let letter = convertSelectionToLetter(selection: gradeModified)
            let gpaKey = "gpa" + letter
            let minKey = "min" + letter
            
            defaults.set(gpaSlider.value, forKey: gpaKey)
            defaults.set(minGrade, forKey: minKey)
            // Set user defaults
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var gpaSlider: UISlider!
    
    @IBAction func gpaSliderMoved(_ sender: UISlider) {
        
        sender.setValue((Float(lroundf(gpaSlider.value/0.1))*0.1), animated: true)
        
        self.gpaLabel.text = NSString.localizedStringWithFormat("%.1f%", self.gpaSlider.value) as String
    }
    
    @IBOutlet weak var gpaLabel: UILabel!

    @IBOutlet weak var minRequiredText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let letter = convertSelectionToLetter(selection: gradeModified)
        let gpaKey = "gpa" + letter
        let minKey = "min" + letter
        let gpaKeyValue = defaults.float(forKey:gpaKey)
        let minKeyValue = defaults.float(forKey:minKey)
        let minKeyString = String(format: "%.0f", minKeyValue)
        
        gpaSlider.value = gpaKeyValue
        gpaLabel.text = String(gpaKeyValue)
        minRequiredText.text = minKeyString + "%"
        
        self.title = letter
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func convertSelectionToLetter(selection: Int) -> String {
        if(selection == 0){
            return "A+"
        }
        if(selection == 1){
            return "A"
        }
        else if(selection == 2){
            return "A-"
        }
        else if(selection == 3){
            return "B+"
        }
        else if(selection == 4){
            return "B"
        }
        else if(selection == 5){
            return "B-"
        }
        else if(selection == 6){
            return "C+"
        }
        else if(selection == 7){
            return "C"
        }
        else if(selection == 8){
            return "C-"
        }
        else if(selection == 9){
            return "D+"
        }
        else if(selection == 10){
            return "D"
        }
        else if(selection == 11){
            return "D-"
        }
        else {
            return "F"
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /* func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
    }
     */

}
