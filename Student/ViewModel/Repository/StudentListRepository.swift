//
//  CardRepository.swift
//  Student
//
//  Created by TAN PHUC on 04/06/2023.
//

// 1
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// 2
class StudentListRepository: ObservableObject {
    // 3
    private let path: String = "students"
    // 4
    private let store = Firestore.firestore()
    
    
    
    // 5
    func add(_ student: Student) {
        do {
            // 6
            _ = try store.collection(path).document(student.id).setData([
                "id":student.id,
                "name":student.name,
                "phone":student.phone,
                "address":student.address,
                "point":student.point,
                "classId":student.classId,
                "behaviorList": student.behaviorList
                
                
            ])
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
        }
    }
    
    func delete(_ studentId: String) {
        
        do {
            
            
            try store.collection(path).document(studentId).delete()
            { err in
                if let err = err {
                    print("Error removing document: \(err)")
                }
                else {
                    print("Document successfully removed!")
                }
            }
            
        } catch {
            
            fatalError("Unable to add student: \(error.localizedDescription).")
        }
    }
    
    
    func get(classId: String) async -> [Student]{
        do {
            var list = [Student]()
            
            
            let snapshot = try await store.collection(path)
                .whereField("classId", isEqualTo: classId)
                .getDocuments()
            
          try  snapshot.documents.forEach {
                documentSnapshot in
                let documentData = documentSnapshot.data()
                
                
                let id = documentData["id"] as? String ?? ""
                let name = documentData["name"] as? String ?? ""
                let point = documentData["point"] as? String ?? ""
                let phone = documentData["phone"] as? String ?? ""
                let address = documentData["address"] as? String ?? ""
                let classId = documentData["classId"] as? String ?? ""
                let behaviorList = (documentData["behaviorList"] as? [Dictionary<String , Any>] ?? [[:]] )
                
            let challenges = behaviorList.map { challengeDict in

                    
                   let id = challengeDict["id"] as? String ?? ""
                let date = challengeDict["date"] as? String ?? ""
                let behavior = challengeDict["behavior"] as? String ?? ""
                let score = challengeDict["score"] as? String ?? ""
                    
                    return Behavior(id: id, date: date, behavior: behavior, score: score)!
                }
                
                
                list.append(Student(id: id, name: name, point: point, phone: phone, address: address,classId:classId,behaviorList: challenges)!)
                
                
            }
            
            
            
            return list;
            
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
            return [];
        }
    }
    
    func getAll() async -> [Student]{
        do {
            var list = [Student]()
            
            
            let snapshot = try await store.collection(path)
                .getDocuments()
            
         try   snapshot.documents.forEach {
                documentSnapshot in
                let documentData = documentSnapshot.data()
                
                
                let id = documentData["id"] as? String ?? ""
                let name = documentData["name"] as? String ?? ""
                let point = documentData["point"] as? String ?? ""
                let phone = documentData["phone"] as? String ?? ""
                let address = documentData["address"] as? String ?? ""
                let classId = documentData["classId"] as? String ?? ""
                let behaviorList = (documentData["behaviorList"] as? [Dictionary<String , Any>] ?? [[:]] )
                
            let challenges = behaviorList.map { challengeDict in

                    
                   let id = challengeDict["id"] as? String ?? ""
                let date = challengeDict["date"] as? String ?? ""
                let behavior = challengeDict["behavior"] as? String ?? ""
                let score = challengeDict["score"] as? String ?? ""
                    
                    return Behavior(id: id, date: date, behavior: behavior, score: score)!
                }
                
                
                list.append(Student(id: id, name: name, point: point, phone: phone, address: address,classId:classId,behaviorList: challenges)!)
                
                
            }
            
            
            
            return list;
            
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
            return [];
        }
    }
    
    
    func getInfo(studentId: String) async -> Student?{
        do {
            var item: Student? = nil
            
            
            let snapshot = try await store.collection(path)
                .whereField("id", isEqualTo: studentId).limit(to: 1)
                .getDocuments()
            
        try    snapshot.documents.forEach {
                documentSnapshot in
                let documentData = documentSnapshot.data()
                
                
                let id = documentData["id"] as? String ?? ""
                let name = documentData["name"] as? String ?? ""
                let point = documentData["point"] as? String ?? ""
                let phone = documentData["phone"] as? String ?? ""
                let address = documentData["address"] as? String ?? ""
                let classId = documentData["classId"] as? String ?? ""
            

                let behaviorList = (documentData["behaviorList"] as? [Dictionary<String , Any>] ?? [[:]] )
                
            let challenges = behaviorList.map { challengeDict in

                    
                   let id = challengeDict["id"] as? String ?? ""
                let date = challengeDict["date"] as? String ?? ""
                let behavior = challengeDict["behavior"] as? String ?? ""
                let score = challengeDict["score"] as? String ?? ""
                    
                    return Behavior(id: id, date: date, behavior: behavior, score: score)!
                }
                
            item = (Student(id: id, name: name, point: point, phone: phone, address: address,classId:classId,behaviorList:challenges )!)
                
                
            }
            
            
            
            return item;
            
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
            return nil;
        }
    }
    
    
    
    func update(_ student: Student) {
        do {
            // 6
            _ = try store.collection(path).document(student.id).updateData([
                "id":student.id,
                "name":student.name,
                "phone":student.phone,
                "address":student.address,
                "point":student.point,
                "classId":student.classId,
                "behaviorList": student.behaviorList.map({
                    
                    let encodedData = try JSONEncoder().encode($0)
                    return [
                        "id":$0.id,
                        "behavior":$0.behavior,
                        "date":$0.date,
                        "score":$0.score
                    ]
                    
                    
                    
                })
                
                
            ])
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
        }
    }
    
}


