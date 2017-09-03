//
//  Semester.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-22.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

class Semester: NSObject, NSCoding {

    var name: String
    var courses = [Course]()
    
    init(semesterName: String) {
        self.name = semesterName
        super.init()
        //New Instance initialization goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = ""
        super.init()
        
        if let archivedName = aDecoder.decodeObject(forKey: "name") as? String {
            name = archivedName
        }
        if let archivedCourses = aDecoder.decodeObject(forKey: "courses") as? [Course] {
            courses = archivedCourses
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(courses, forKey: "courses")
    }
    
    func calculateSemesterAverage() -> Float {
        var averageSum: Float = 0.0
        var creditUsed: Float = 0.0
        
        for course in courses {
            averageSum += (Float(course.calculateCourseAverage())*course.credit)
            creditUsed += course.credit
        }
       
        if(creditUsed == 0.0) {
            return 0.0
        }
        else {
            return (averageSum/creditUsed)
        }
    }
    
    func calculateSemesterGPA() -> Float {
        var gpaSum: Float = 0.0
        var creditUsed: Float = 0.0
    
        for course in courses {
            if(course.countToGPA) {
                gpaSum += (Float(course.calculateCourseGPA())*course.credit)
                creditUsed += course.credit
            }
        }
         
        if(creditUsed == 0.0) {
            return 0.0
        }
        else {
            return (gpaSum/creditUsed)
        }
    }
    
    func calculateSemesterCredits() -> Float {
        var creditSum: Float = 0.0
        
        for course in courses {
            if ((course.calculateCourseAverage() >= 50) && (course.calculateWeightUsed() >= 100)) {
                creditSum += course.credit
            }
        }
        return creditSum
    }
}

