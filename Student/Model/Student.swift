

import UIKit

class Student:Codable {
    
    let id :String

    let name: String
    let point: String
    let phone: String
    let address: String
    let classId: String
    let behaviorList: [Behavior]

    //MARK: constructors
    init?(id:String, name:String, point:String,phone:String, address:String,classId:String, behaviorList: [Behavior]) {
      
        self.id = id
        self.name = name
        self.point = point
        self.phone = phone
        self.address = address
        self.classId = classId
        self.behaviorList = behaviorList
    }
    
    func copy(with behaviorList: [Behavior]) -> Student {
            let copy = Student(id: id, name: name, point: point, phone: phone, address: address, classId: classId, behaviorList: behaviorList)
        return copy!
        }
}

class Behavior:Codable {
    
    let id :String

    let date: String
    let behavior: String
    let score: String


    //MARK: constructors
    init?(id:String, date:String, behavior:String,score:String) {
      
        self.id = id
        self.date = date
        self.behavior = behavior
        self.score = score

    }
}
