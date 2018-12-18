//
//  Person.swift
//  SeventhWork
//
//  Created by student on 2018/11/21.
//  Copyright © 2018年 yls. All rights reserved.
//

import Foundation

enum Gender:Int {
    case male       //男
    case female     //女
    case unknow     //未知
}

enum Department {   //公寓
    case one,two,three
}

//学校协议
protocol SchoolProtocol {
    var department:Department { get set }
    func lenbook()
}

//Person类
class Person {
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    
    var fullName:String {
        get{
            return firstName + lastName
        }
    }
    
    init(firstName:String, lastName:String, age:Int, gender:Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
}

//教师类
class Teacher: Person, SchoolProtocol {
    var title:String
    var department: Department
    
    init(title:String, firstName:String, lastName:String, age:Int, gender:Gender, department:Department) {
        self.title = title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    func lenbook() {
    }
    
    
}

//学生类
class Student: Person, SchoolProtocol {
    var  stuNo:Int
    var department: Department
    
    init(stuNo:Int, firstName:String, lastName:String, age:Int, gender:Gender, department:Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    func lenbook() {
    }
    
    
}
