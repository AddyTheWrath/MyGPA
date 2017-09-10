//
//  Course.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-22.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

class Course: NSObject, NSCoding {
    
    var name: String
    var credit: Float
    var assignments = [Assignment]()
    var desiredGrade: Int
    var countToGPA: Bool

    init(courseName: String, courseCredit: Float, desiredCourseGrade: Int, countTowardsGPA: Bool) {
        self.name = courseName
        self.credit = courseCredit
        self.desiredGrade = desiredCourseGrade
        self.countToGPA = countTowardsGPA
        super.init()
        
        //New Instance initialization goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = ""
        self.credit = 0.0
        self.desiredGrade = 0
        self.countToGPA = true
        super.init()
        
        if let archivedName = aDecoder.decodeObject(forKey: "courseName") as? String {
            name = archivedName
        }
        if let archivedAssignments = aDecoder.decodeObject(forKey: "assignments") as? [Assignment] {
            assignments = archivedAssignments
        }
        if aDecoder.containsValue(forKey: "courseCredit") {
            self.credit = aDecoder.decodeFloat(forKey: "courseCredit")
        }
        if aDecoder.containsValue(forKey: "desiredCourseGrade") {
            self.desiredGrade = aDecoder.decodeInteger(forKey: "desiredCourseGrade")
        }
        if aDecoder.containsValue(forKey: "countToGPA") {
            self.countToGPA = aDecoder.decodeBool(forKey: "countToGPA")
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "courseName")
        aCoder.encode(assignments, forKey: "assignments")
        aCoder.encode(credit, forKey: "courseCredit")
        aCoder.encode(desiredGrade, forKey: "desiredCourseGrade")
        aCoder.encode(countToGPA, forKey: "countToGPA")
    }
    
    func calculateCourseAverage() -> Float {
        var agregateAverage = 0.0
        var weightUsed = 0.0
        
        for assignment in assignments {
            agregateAverage += ((Double(assignment.grade)/100)*Double(assignment.weight))
            weightUsed += Double(assignment.weight)
        }
        
        if(weightUsed>0) {
            return Float((agregateAverage/weightUsed)*100)
        }
        else {
            return 0.0
        }
    }
    
    func calculateCourseGPA() -> Float {
        
        let x = calculateCourseAverage()
        
        // Not defining user inputted values (JUST U OF T)
        
        if(x>=85) { //A and A+
            return 4.0
        }
        else if(80<=x && x<85) { //A-
            return 3.7
        }
        else if(77<=x && x<80) { //B+
            return 3.3
        }
        else if(73<=x && x<77) { //B
            return 3.0
        }
        else if(70<=x && x<73) { //B-
            return 2.7
        }
        else if(67<=x && x<70) { //C+
            return 2.3
        }
        else if(63<=x && x<67) { //C
            return 2.0
        }
        else if(60<=x && x<63) { //C-
            return 1.7
        }
        else if(57<=x && x<60) { //D+
            return 1.3
        }
        else if(53<=x && x<57) { //D
            return 1.0
        }
        else if(50<=x && x<53) { //D-
            return 0.7
        }
        else { //F
            return 0.0
        }
    }
    
    func calculateCourseAverageNeeded() -> Float {
        var agregateAverage = 0.0
        var weightUsed = 0.0
        
        for assignment in assignments {
            agregateAverage += ((Double(assignment.grade)/100)*Double(assignment.weight))
            weightUsed += Double(assignment.weight)
         }
        
        if(weightUsed >= 100.0) {
            return 10000.00
        }
        else {
            return Float(((Double(self.desiredGrade) - agregateAverage)/(100 - weightUsed))*100)
        }
    }
    
    /* func calculateCourseAverageH() -> Float {
        
        var agregateAverage = 0.0
        var weightUsed = 0.0
        
        for assignment in assignments {
            agregateAverage += ((Double(assignment.grade)/100)*Double(assignment.weight))
            weightUsed += Double(assignment.weight)
        }
        
        if(weightUsed >= 100.0) {
            return 10000.00
        }
        else {
            return Float(((80 - agregateAverage)/(100 - weightUsed))*100)
        }
    } */
    
    func calculateWeightUsed() -> Int {
        var weight = 0
        
        for assignment in assignments {
            weight += assignment.weight
        }
        return weight
    }
}
