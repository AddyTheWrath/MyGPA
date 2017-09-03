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
        let defaults = UserDefaults.standard
        
        let gpaAPlus = defaults.float(forKey: "gpaA+")
        let minAPlus = defaults.float(forKey: "minA+")
        
        let gpaA = defaults.float(forKey: "gpaA")
        let minA = defaults.float(forKey: "minA")
        
        let gpaAMinus = defaults.float(forKey: "gpaA-")
        let minAMinus = defaults.float(forKey: "minA-")
        
        let gpaBPlus = defaults.float(forKey: "gpaB+")
        let minBPlus = defaults.float(forKey: "minB+")
        
        let gpaB = defaults.float(forKey: "gpaB")
        let minB = defaults.float(forKey: "minB")
        
        let gpaBMinus = defaults.float(forKey: "gpaB-")
        let minBMinus = defaults.float(forKey: "minB-")
        
        let gpaCPlus = defaults.float(forKey: "gpaC+")
        let minCPlus = defaults.float(forKey: "minC+")
        
        let gpaC = defaults.float(forKey: "gpaC")
        let minC = defaults.float(forKey: "minC")
        
        let gpaCMinus = defaults.float(forKey: "gpaC-")
        let minCMinus = defaults.float(forKey: "minC-")
        
        let gpaDPlus = defaults.float(forKey: "gpaD+")
        let minDPlus = defaults.float(forKey: "minD+")
        
        let gpaD = defaults.float(forKey: "gpaD")
        let minD = defaults.float(forKey: "minD")
        
        let gpaDMinus = defaults.float(forKey: "gpaD-")
        let minDMinus = defaults.float(forKey: "minD-")
        
        let gpaF = defaults.float(forKey: "gpaF")
        
        if(minAPlus<=x && x<=100) { //A and A+
            return gpaAPlus
        }
        else if(minA<=x && x<minAPlus) {
            return gpaA
        }
        else if(minAMinus<=x && x<minA) { //A-
            return gpaAMinus
        }
        else if(minBPlus<=x && x<minAMinus) { //B+
            return gpaBPlus
        }
        else if(minB<=x && x<minBPlus) { //B
            return gpaB
        }
        else if(minBMinus<=x && x<minB) { //B-
            return gpaBMinus
        }
        else if(minCPlus<=x && x<minBMinus) { //C+
            return gpaCPlus
        }
        else if(minC<=x && x<minCPlus) { //C
            return gpaC
        }
        else if(minCMinus<=x && x<minC) { //C-
            return gpaCMinus
        }
        else if(minDPlus<=x && x<minCMinus) { //D+
            return gpaDPlus
        }
        else if(minD<=x && x<minDPlus) { //D
            return gpaD
        }
        else if(minDMinus<=x && x<minD) { //D-
            return gpaDMinus
        }
        else { //F
            return gpaF
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
