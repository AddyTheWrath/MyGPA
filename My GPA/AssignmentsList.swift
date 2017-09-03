//
//  AssignmentsList.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-25.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol AssignmentsListDelegate {
    func controller(controller: AssignmentsList)
}

class AssignmentsList: UIViewController, AddAssignmentDelegate, AssignmentPageDelegate, EditCourseDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func controller(controller: AssignmentPage) {
        
    }
    
    func controller(controller: newAssignment, didSaveAssignmentWithName name: String, andGrade grade: Int, andWeight weight: Int) {
        
        let assignment = Assignment(assignmentName: name, assignGrade: grade, assignWeight: weight)
        // Create assignment

        course.assignments.append(assignment)
        // Add assignment to assignments array

        func reloadData() {}
        // Refresh table view data

        tableView.insertRows(at: [NSIndexPath(row: (course.assignments.count - 1), section: 0) as IndexPath], with: .none)
        // Insert row
        
        saveSemesters()
        // Save
    }
    
    func controller(controller: courseSettings, didEditCourseWithName name: String, andEditCredit credit: Float, andEditDesiredGrade desiredGrade: Int, andCountToGPA countToGPA: Bool) {
        
        course.name = name
        course.credit = credit
        course.desiredGrade = desiredGrade
        course.countToGPA = countToGPA
        // Edit course information
        
        saveSemesters()
        // Save
    }
    
    let CellIdentifier = "InnerInnerCellIdentifier"
    var course: Course!
    var delegate: AssignmentsListDelegate?
    var selection: Assignment?
    var semestersList = [Semester]()
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var courseInformation: UILabel!
    
    @IBOutlet weak var courseInformationTwo: UILabel!
    
    @IBOutlet weak var courseInformationThree: UILabel!

    @IBOutlet weak var courseInformationFour: UILabel!
    
    @IBOutlet weak var courseSettings: UIButton!
    
    @IBAction func courseSettingsPressed(_ sender: Any) {
        performSegue(withIdentifier: "courseSettings", sender: self)
    }
    
    private func pathForSemesters() -> String? {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("semestersList")?.path
        }
        return nil
    }
    
    private func saveSemesters() {
        if let filePath = pathForSemesters() {
            NSKeyedArchiver.archiveRootObject(semestersList, toFile: filePath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(course.assignments)
        
        courseInformation.text = "Current GPA: \(course.calculateCourseGPA())\n\n Current Average: \(course.calculateCourseAverage())%"
       
        if(course.calculateWeightUsed() >= 100) {
            courseInformationTwo.text = "    "
        }
        else {
            let averageNeededF = String(format: "%.2f", course.calculateCourseAverageNeeded())
            
            courseInformationTwo.text = "You need at least \(averageNeededF)% for your desired grade"
        }
        
        courseInformationThree.text = "Cr: \(course.credit)"
        courseInformationFour.text = "Percentage of course completed: \(course.calculateWeightUsed())%"
        
        self.title = course.name
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        tableView.tableFooterView = UIView()

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
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: row, animated: false)
        }
        courseInformation.text = "Current GPA: \(course.calculateCourseGPA())\n\n Current Average: \(course.calculateCourseAverage())%"
        
        if(course.calculateWeightUsed() >= 100) {
            courseInformationTwo.text = "     "
        }
        else {
            let averageNeededF = String(format: "%.2f", course.calculateCourseAverageNeeded())
            
            courseInformationTwo.text = "You need at least \(averageNeededF)% for your desired grade"
        }
        
        courseInformationThree.text = "Cr: \(course.credit)"
        courseInformationFour.text = "Percentage of course completed: \(course.calculateWeightUsed())%"
        
        self.title = course.name
        
        // Refresh data during a dismiss transition
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return course.assignments.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InnerInnerCellIdentifier", for: indexPath)
        // Dequeue Reusable Cell

        let assignment = course.assignments[indexPath.row]
        // Fetch Item

        // Configure Table View Cell
        cell.textLabel?.text = assignment.name
        
        return cell

    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            course.assignments.remove(at: indexPath.row)
            //Delete assignment from assignments

            tableView.deleteRows(at: [indexPath as IndexPath], with: .right)
            // Delete the row from the data source

            saveSemesters()
            //Save
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let assignment = course.assignments[indexPath.row]
        
        selection = assignment
        // Update Selection

        performSegue(withIdentifier: "Assignment", sender: self)
        // Perform Segue
    }
    

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newAssignment" {
            if let navigationController = segue.destination as? UINavigationController,
                let NewAssignment = navigationController.viewControllers.first as? newAssignment {
                NewAssignment.delegate = self
            }
        } else if segue.identifier == "Assignment" {
            if let navigationController = segue.destination as? UINavigationController,
                let assignmentPage = navigationController.viewControllers.first as? AssignmentPage {
                assignmentPage.delegate = self
                assignmentPage.assignment = selection
            }
        } else if segue.identifier == "courseSettings" {
            if let navigationController = segue.destination as? UINavigationController,
                let coursesettings = navigationController.viewControllers.first as? courseSettings {
                coursesettings.delegate = self
                coursesettings.course = course
            }
        }
        // Navigation to new assignment, specific assignment screen, or course settings
    }
}
