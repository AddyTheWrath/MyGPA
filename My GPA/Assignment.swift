//
//  Assignment.swift
//  My GPA
//
//  Created by Adhirath Sreekanth  on 2017-08-22.
//  Copyright © 2017 ADDY. All rights reserved.
//

import UIKit

class Assignment: NSObject, NSCoding {
    
    var name: String
    var grade: Int
    var weight: Int
    
    init(assignmentName: String, assignGrade: Int, assignWeight: Int) {
        self.name = assignmentName
        self.grade = assignGrade
        self.weight = assignWeight
        super.init()
        //New Instance initialization goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = ""
        self.grade = 0
        self.weight = 0
        super.init()
        
        if let archivedName = aDecoder.decodeObject(forKey: "assignmentName") as? String{
            self.name = archivedName
        }
        if aDecoder.containsValue(forKey: "assignmentGrade"){
            self.grade = aDecoder.decodeInteger(forKey: "assignmentGrade")
        }
        if aDecoder.containsValue(forKey: "assignmentWeight"){
            self.weight = aDecoder.decodeInteger(forKey: "assignmentWeight")
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "assignmentName")
        aCoder.encode(grade, forKey: "assignmentGrade")
        aCoder.encode(weight, forKey: "assignmentWeight")
    }
}
