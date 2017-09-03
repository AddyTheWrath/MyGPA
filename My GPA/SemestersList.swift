//
//  SemestersList.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-22.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

class SemestersList: UIViewController, AddSemesterDelegate, CoursesListDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func controller(controller: CoursesList) {
    }
    
    func controller(controller: newSemester, didSaveSemesterWithName name: String) {
        
        let semester = Semester(semesterName: name)
        // Create Semester
        
        semestersList.append(semester)
        // Add semester to Semesters array
        
        func reloadData() {}
        // Refresh table view data
        
        tableView.insertRows(at: [NSIndexPath(row: (semestersList.count - 1), section: 0) as IndexPath], with: .none)
        // Insert row in table
        
        saveSemesters()
        // Save
    }
    
    let CellIdentifier = "CellIdentifier"
    var semestersList = [Semester]()
    var selection: Semester?
    
    @IBOutlet weak var backButton: UIBarButtonItem!
   
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var semestersInformation: UILabel!
    
    @IBOutlet weak var semesterInformationTwo: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadSemesters()
        // Initial load
    }
    
    private func loadSemesters() {
        // Helper function to load semesters
        
        if let filePath = pathForSemesters(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedSemesters = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Semester] {
                semestersList = archivedSemesters
            }
        }
    }
    
    private func pathForSemesters() -> String? {
        // Helper function to find location of saved semesters (if it exists)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("semestersList")?.path
        }
        return nil
    }
    
    private func saveSemesters() {
        // Helper function to save new data
        
        if let filePath = pathForSemesters() {
            NSKeyedArchiver.archiveRootObject(semestersList, toFile: filePath)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(semestersList)
        
        let cgpaText = String(format: "%.2f", calculateCGPA())
        let totalCreditsText = String(format: "%.1f", calculateTotalCredits())
        
        semestersInformation.text = "Your CGPA: \(cgpaText)"
        semesterInformationTwo.text = "Total Credits: \(totalCreditsText)"
        
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
    
    func calculateCGPA() -> Double {
        
        var allSemestersGPA = 0.0
        
        for semester in semestersList {
            allSemestersGPA += Double(semester.calculateSemesterGPA())
        }
        
        if(semestersList.count == 0) {
            return 0.0
        }
        else {
            return (allSemestersGPA/Double(semestersList.count))
        }
    }
    
    func calculateTotalCredits() -> Double {
        var allsemestersTotalCredits = 0.0
        
        for semester in semestersList {
            allsemestersTotalCredits += Double(semester.calculateSemesterCredits())
        }
        
        return allsemestersTotalCredits
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: row, animated: false)
        }
        
        self.tableView.reloadData()
        
        let cgpaText = String(format: "%.2f", calculateCGPA())
        let totalCreditsText = String(format: "%.1f", calculateTotalCredits())

        semestersInformation.text = "Your CGPA: \(cgpaText)"
        semesterInformationTwo.text = "Total Credits Received: \(totalCreditsText)"
        
        // Refresh data during a dismiss transition
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return semestersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        // Dequeue Reusable Cell

        let semester = semestersList[indexPath.row]
        // Fetch semester

        cell.textLabel?.text = semester.name
        // Configure Table View Cell

        return cell
    }
    

     //Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            semestersList.remove(at: indexPath.row)
            // Delete semester from Semesters

            tableView.deleteRows(at: [indexPath as IndexPath], with: .right)
            // Delete the row from the data source

            saveSemesters()
            // Save
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let semester = semestersList[indexPath.row]
        
        selection = semester
        // Update Selection
        
        performSegue(withIdentifier: "CoursesList", sender: self)
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
        if segue.identifier == "newSemester" {
            if let navigationController = segue.destination as? UINavigationController,
                let NewSemester = navigationController.viewControllers.first as? newSemester {
                NewSemester.delegate = self
            }
        } else if segue.identifier == "CoursesList" {
            if let navigationController = segue.destination as? UINavigationController,
                let courseslist = navigationController.viewControllers.first as? CoursesList {
                courseslist.delegate = self
                courseslist.semester = selection
                courseslist.semestersList = semestersList
                
            }
        }
        // Navigation to new semester screen or specific semester screen
    }
}
