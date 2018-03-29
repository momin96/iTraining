//: Playground - noun: a place where people can play

import Cocoa

@objc class Student : NSObject {
    @objc dynamic var name : NSString = ""
    @objc var gradeLevel = 0;
}
var s = Student()
s.setValue("Nasir", forKey: "name")
s.setValue(10, forKey: "gradeLevel")


