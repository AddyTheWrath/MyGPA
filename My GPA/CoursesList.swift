//
//  CoursesList.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-24.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

protocol CoursesListDelegate {
    func controller(controller: CoursesList)
}

class CoursesList: UIViewController, AddCourseDelegate, AssignmentsListDelegate, EditSemesterDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func controller(controller: AssignmentsList) {
    }
    
    func controller(controller: newCourse, didSaveCourseWithName name: String, andCredit credit: Float, andDesiredGrade desiredGrade: Int, andCountToGPA countToGPA: Bool) {
        
        let course = Course(courseName: name, courseCredit: credit, desiredCourseGrade: desiredGrade, countTowardsGPA: countToGPA)
        // Create Course

        semester.courses.append(course)
        // Add course to Courses array

        func reloadData() {}
        // Refresh table view data

        tableView.insertRows(at: [NSIndexPath(row: (semester.courses.count - 1), section: 0) as IndexPath], with: .none)
        // Insert row
        
        saveSemesters()
        //Save
    }
    
    func controller(controller: semesterSettings, didEditSemesterWithName name: String) {
        
        semester.name = name
        // Edit semester information
        
        saveSemesters()
        // Save
    }
    
    let CellIdentifier = "InnerCellIdentifier"
    var semester: Semester!
    var delegate: CoursesListDelegate?
    var selection: Course?
    var semestersList = [Semester]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var semesterInformation: UILabel!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var semesterInformationTwo: UILabel!
    
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
        
        print(semester.courses)

        semesterInformation.text = "GPA: \(semester.calculateSemesterGPA())\n\n Average: \(semester.calculateSemesterAverage())%"
        semesterInformationTwo.text = "Credits Received: \(semester.calculateSemesterCredits())"
        
        self.title = semester.name
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: row, animated: false)
        }
        semesterInformation.text = "Current GPA: \(semester.calculateSemesterGPA())\n\n Current Average: \(semester.calculateSemesterAverage())%"
        semesterInformationTwo.text = "Credits: \(semester.calculateSemesterCredits())"
        
        self.title = semester.name
        
        // Refresh data during a dismiss transition
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return semester.courses.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InnerCellIdentifier", for: indexPath)
        // Dequeue Reusable Cell

        let course = semester.courses[indexPath.row]
        // Fetch course

        cell.textLabel?.text = course.name
        // Configure Table View Cell

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
            
            semester.courses.remove(at: indexPath.row)
            //Delete course from Courses

            tableView.deleteRows(at: [indexPath as IndexPath], with: .right)
            // Delete the row from the data source

            saveSemesters()
            //Save
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = semester.courses[indexPath.row]
        
        selection = course
        // Update Selection

        performSegue(withIdentifier: "AssignmentsList", sender: self)
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
        if segue.identifier == "newCourse" {
            if let navigationController = segue.destination as? UINavigationController,
                let NewCourse = navigationController.viewControllers.first as? newCourse {
                NewCourse.delegate = self
            }
        } else if segue.identifier == "AssignmentsList" {
            if let navigationController = segue.destination as? UINavigationController,
                let assignmentslist = navigationController.viewControllers.first as? AssignmentsList {
                assignmentslist.delegate = self
                assignmentslist.course = selection
                assignmentslist.semestersList = semestersList
                
            }
        } else if segue.identifier == "semesterSettings" {
            if let navigationController = segue.destination as? UINavigationController,
                let semestersettings = navigationController.viewControllers.first as? semesterSettings {
                semestersettings.delegate = self
                semestersettings.semester = semester
            }
        }
        // Navigation to new course, specific course screen, or semester settings
    }
}
